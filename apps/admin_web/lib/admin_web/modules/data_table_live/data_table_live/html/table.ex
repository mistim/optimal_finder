defmodule DataTableLive.HTML.Table do
  @moduledoc "Builds the table part of the HTML"
  alias DataTableLive.{Params, Text}
  alias DataTableLive.HTML.{ActionButton, Filter, Format, Helpers}
  alias Phoenix.HTML.Tag

  @doc "Output the table as HTML"
  @spec build(map) :: {:safe, iolist}
  def build(%{params: %Params{fields: fields, list: list} = params} = assigns) do
    head =
      fields
      |> Filter.fields_where_not(:hidden)
      |> add_actions_header(assigns)
      |> Enum.map(fn column -> table_header(column, params) end)
      |> Helpers.tag(:thead, class: "bg-gray-100 border-b border-gray-300")

    body =
      list
      |> Enum.map(fn entry -> build_row(entry, assigns) end)
      |> Helpers.tag(:tbody, class: "bg-white divide-y divide-gray-200")

    [head, body]
    |> Helpers.tag(:table, class: "table-fixed min-w-full divide-y_ divide-gray-200_")
    |> maybe_nothing_found(params)
    |> Helpers.tag(:div, class: "shadow overflow-hidden")
    |> Helpers.tag(:div, class: "align-middle inline-block min-w-full")
    |> Helpers.tag(:div, class: "overflow-x-auto")
    |> Helpers.tag(:div, class: "flex flex-col mb-4 border-t border-gray-200")
  end

  @spec add_actions_header(keyword, map) :: keyword
  defp add_actions_header(fields, %{params: %Params{action_buttons: []}}), do: fields

  defp add_actions_header(fields, _assigns) do
    fields ++ [actions: %{sort: false, search: false, order: false}]
  end

  @spec table_header({atom, map}, Params.t()) :: {:safe, iolist}
  defp table_header(field, %Params{} = params) do
    [Format.header(params, field), hide_link_for(field, params), sort_link_for(field, params)]
    |> Helpers.tag(:th, class: "p-4 text-left text-xs font-medium text-gray-500 uppercase")
  end

  @spec build_row(atom, map) :: {:safe, iolist}
  defp build_row(entry, %{params: %Params{fields: fields}} = assigns) do
    values =
      fields
      |> Filter.fields_where_not(:hidden)
      |> Keyword.keys()
      |> Enum.map(fn key -> Format.field(entry, key, assigns) end)
      |> Enum.map(fn value -> Helpers.tag(value, :td, class: "p-4 whitespace-nowrap space-x-2") end)

    values
    |> Kernel.++([build_actions(entry, assigns)])
    |> Helpers.tag(:tr, class: "hover:bg-gray-100 border-b border-gray-300")
  end

  @spec build_actions(atom, map) :: {:safe, iolist}
  defp build_actions(_entry, %{params: %Params{action_buttons: []}}), do: ""

  defp build_actions(entry, %{params: params} = assigns) do
    params
    |> Map.get(:action_buttons)
    |> Kernel.--([:new])
    |> Enum.map(fn action -> ActionButton.build(action, entry, assigns) end)
    |> Helpers.tag(:td, class: "p-4 whitespace-nowrap space-x-2")
  end

  @spec hide_link_for({atom, map}, Params.t()) :: {:safe, iolist}
  defp hide_link_for({:actions, _value}, _params), do: {:safe, [""]}
  defp hide_link_for(_, %Params{disable_hide: true}), do: {:safe, [""]}

  defp hide_link_for({key, _value}, %Params{} = params) do
    params
    |> Text.text(:hide)
    |> Helpers.tag(:a,
      class: "exz-hide-link",
      "phx-click": "hide_column",
      "phx-value-column": key
    )
  end

  @spec sort_link_for({atom, map}, Params.t()) :: {:safe, iolist}
  defp sort_link_for({:actions, _v}, _params), do: {:safe, [""]}
  defp sort_link_for({_key, %{order: false}}, _params), do: {:safe, [""]}

  defp sort_link_for({key, _v}, %Params{order: order} = params) do
    sort = Text.text(params, :sort)

    label =
      case order do
        [desc: ^key] -> "#{sort} ▲"
        [asc: ^key] -> "#{sort} ▼"
        _ -> "#{sort}  "
      end

    Tag.content_tag(:a, label,
      class: "exz-sort-link",
      "phx-click": "sort_column",
      "phx-value-column": key
    )
  end

  defp maybe_nothing_found(content, %Params{list: []} = params) do
    nothing_found =
      params
      |> Text.text(:nothing_found)
      |> Helpers.tag(:div, class: "p-4 border-b border-gray-300")

    [content, nothing_found]
  end

  defp maybe_nothing_found(content, _params) do
    content
  end
end
