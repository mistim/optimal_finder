defmodule OptimalFinder.Goods do
  @moduledoc """
  The Goods context.
  """

  import Ecto.Query, warn: false
  alias OptimalFinder.Repo

  alias OptimalFinder.Goods.Catalog

  @doc """
  Returns the list of catalogs.

  ## Examples

      iex> list_catalogs()
      [%Catalog{}, ...]

  """
  def list_catalogs do
    Repo.all(Catalog)
  end

  @doc """
  Gets a single catalog.

  Raises `Ecto.NoResultsError` if the Catalog does not exist.

  ## Examples

      iex> get_catalog!(123)
      %Catalog{}

      iex> get_catalog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_catalog!(id), do: Repo.get!(Catalog, id)

  @doc """
  Creates a catalog.

  ## Examples

      iex> create_catalog(%{field: value})
      {:ok, %Catalog{}}

      iex> create_catalog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_catalog(attrs \\ %{}) do
    %Catalog{}
    |> Catalog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a catalog.

  ## Examples

      iex> update_catalog(catalog, %{field: new_value})
      {:ok, %Catalog{}}

      iex> update_catalog(catalog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_catalog(%Catalog{} = catalog, attrs) do
    catalog
    |> Catalog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a catalog.

  ## Examples

      iex> delete_catalog(catalog)
      {:ok, %Catalog{}}

      iex> delete_catalog(catalog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_catalog(%Catalog{} = catalog) do
    Repo.delete(catalog)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking catalog changes.

  ## Examples

      iex> change_catalog(catalog)
      %Ecto.Changeset{data: %Catalog{}}

  """
  def change_catalog(%Catalog{} = catalog, attrs \\ %{}) do
    Catalog.changeset(catalog, attrs)
  end
end
