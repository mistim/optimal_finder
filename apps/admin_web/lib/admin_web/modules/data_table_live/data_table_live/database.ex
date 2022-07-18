defmodule DataTableLive.Database do
  @moduledoc "Database interactions"
  import Ecto.Query

  @doc "Get the data using query"
  @spec get_records(map) :: [map]
  def get_records(%{query: query} = params) do
    query
    |> order_query(params)
    |> search_query(params)
    |> paginate_query(params)
    |> get_query(params)
  end

  @spec order_query(Ecto.Query.t(), map) :: Ecto.Query.t()
  defp order_query(query, %{order: nil}), do: query

  defp order_query(query, %{order: order}) do
    from(q in exclude(query, :order_by), order_by: ^order)
  end

  @spec search_query(Ecto.Query.t(), map) :: Ecto.Query.t()
  defp search_query(query, %{search: ""}), do: query

  defp search_query(query, %{search: search, module: module}) do
    module.do_search(query, search)
  end

  @spec remove_order(Ecto.Query.t()) :: Ecto.Query.t()
  defp remove_order(query), do: exclude(query, :order_by)

  @spec paginate_query(Ecto.Query.t(), map) :: Ecto.Query.t()
  defp paginate_query(query, %{per_page: per_page, page: 1}) do
    from(q in query, limit: ^per_page)
  end

  defp paginate_query(query, %{per_page: per_page, page: page}) do
    offset = (page - 1) * per_page
    from(q in query, limit: ^per_page, offset: ^offset)
  end

  # Filter out the previous selects and preloads, because we only need the ids to get a count
  @spec select_ids(Ecto.Query.t()) :: Ecto.Query.t()
  defp select_ids(query) do
    query =
      query
      |> exclude(:select)
      |> exclude(:preload)

    from(q in query, select: count(q.id))
  end

  # Repo.all
  @spec get_query(Ecto.Query.t(), map) :: [map]
  defp get_query(query, %{repo: repo}), do: repo.all(query)

  @doc "I want to just do a select: count(c.id)"
  @spec get_record_count(map) :: integer
  def get_record_count(%{query: query} = params) do
    query
    |> select_ids()
    |> search_query(params)
    |> remove_order()
    |> get_query(params)
    |> List.first()
  end

  @doc "We only want letters to avoid SQL injection attacks"
  @spec prefix_search(String.t()) :: String.t()
  def prefix_search(terms) do
    terms
    |> String.trim()
    |> String.replace(~r/[^\w\s]|_/u, "")
    # |> String.replace(~r/\s+/u, ":* & ")
    # |> Kernel.<>(":*")
    |> then(&"%#{&1}%")
  end

  @doc """
    Generates the magic SQL fragment that performs search dynamically.
    Searches across columns that are searchable. Replaces nulls with a space.
    Created outside macro to bypass ecto restrictions
  """
  @spec tsvector_string([keyword]) :: String.t()
  def tsvector_string(fields) do
    fields
    |> Stream.filter(fn {_k, field} -> Keyword.fetch!(field, :search) end)
    |> Enum.map_join(" || ' ' || ", fn {key, _v} -> "coalesce(#{Atom.to_string(key)}, ' ')" end)
    |> then(&"to_tsvector('english', #{&1}) @@ to_tsquery(?)")
  end

  def like_list(fields, search) do
    fields
    |> Stream.filter(fn {_k, field} -> Keyword.fetch!(field, :search) end)
    |> Enum.reduce([], fn _x, acc -> [search | acc] end)
  end

  @spec search_like([keyword]) :: String.t()
  def search_like(fields) do
    fields
    |> Stream.filter(fn {_k, field} -> Keyword.fetch!(field, :search) end)
    |> Enum.map_join(", ", fn {key, _v} -> "#{Atom.to_string(key)}" end)
    |> then(&"CONCAT_WS(' ', #{&1}) LIKE ?")
  end
end
