defmodule DataTableLive.Params do
  @moduledoc """
  Gets default parameters, replaces with module opts and then with the function opts.

  Validates that parameters are valid.
  """
  alias DataTableLive.HTML.Format
  alias DataTableLive.Params.Validations

  @enforce_keys [:query, :repo, :routes, :path, :fields, :module, :csrf_token]

  @type column :: atom
  @type function_name :: atom

  @type t :: %__MODULE__{
          # required
          query: Ecto.Query.t(),
          repo: module,
          routes: module,
          path: atom,
          fields: [{column, keyword}],
          module: module,
          csrf_token: String.t(),
          # optional
          order: [{:asc | :desc, column}] | nil,
          parent: struct | nil,
          belongs_to: atom | nil,
          page: pos_integer,
          count: non_neg_integer,
          list: [struct],
          search: String.t(),
          show_field_buttons: boolean,
          action_buttons: [:new | :show | :edit | :delete],
          per_page: pos_integer,
          debounce: pos_integer,
          refresh: boolean,
          disable_hide: boolean,
          pagination: [:top | :bottom],
          assigns: map,
          text: module,
          formatter: {module, function_name} | {module, function_name, list}
        }

  defstruct [
    # required
    :query,
    :repo,
    :routes,
    :path,
    :fields,
    :module,
    :csrf_token,
    # optional
    :order,
    :parent,
    :belongs_to,
    page: 1,
    count: 0,
    list: [],
    search: "",
    show_field_buttons: false,
    action_buttons: [:new, :show, :edit, :delete],
    per_page: 20,
    debounce: 300,
    refresh: false,
    disable_hide: false,
    pagination: [:top, :bottom],
    assigns: %{},
    text: DataTableLive.Text.Default,
    formatter: {Format, :format_field}
  ]

  @default_fields [
    label: nil,
    function: false,
    hidden: false,
    search: true,
    order: true,
    formatter: {Format, :format_field}
  ]

  @virtual_fields [
    function: true,
    search: false,
    order: false
  ]

  @dt_classes %{
    wrapper: "bg-white pb-4 border-b border-gray-200",
    nav_row: "flex items-center justify-between p-4",
    pager_wrapper: "mb-1 flex items-center",
    pager_nav: "",
    pager_ul: "",
    pager_li: "inline py-2 px-3 rounded-xl mx-1 cursor-pointer",
    pager_li_active: "bg-primary-700 text-white",
    pager_li_disable: "opacity-50 bg-gray-100 cursor-not-allowed",
    pager_link: "",
    search_wrappwer: "",
    search_form: "",
    search_field_wrapper: "mt-0 flex items-center lg:w-96",
    search_field: "bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-l-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full pr-10 p-2.5",
    counter_field_wrapper: "px-3 py-2 rounded-r-lg border border-l-0 border-gray-300 flex items-center z-30",
    counter_field: "",
    info_button: "rounded-xl cursor-pointer py-1 px-2 mx-2 border border-gray-300",
    show_button: "rounded-xl cursor-pointer py-1 px-2 mx-2",
  }

  @doc "Gets fields from options and merges it into the defaults"
  @spec set_fields(keyword) :: [any]
  def set_fields(opts) do
    opts
    |> Keyword.get(:fields, [])
    |> Enum.map(fn {key, field} -> {key, merge_fields(field)} end)
  end

  # If virtual: true, a number of other options have to be overridden
  @spec merge_fields(keyword) :: keyword
  defp merge_fields(field) do
    if Keyword.get(field, :virtual) do
      @default_fields
      |> Keyword.merge(field)
      |> Keyword.merge(@virtual_fields)
    else
      Keyword.merge(@default_fields, field)
    end
  end

  @doc "Creates a new params struct, holds state for liveview"
  @spec new(keyword, keyword, atom) :: map
  def new(function_opts, module_opts, module) do
    fields =
      module_opts
      |> set_fields()
      |> Enum.map(fn {k, f} -> {k, Enum.into(f, %{})} end)

    token = Phoenix.Controller.get_csrf_token()

    module_opts
    |> Keyword.merge(function_opts)
    |> Map.new()
    |> Map.merge(%{fields: fields, module: module, csrf_token: token})
    |> Validations.paired_options()
    |> Validations.required_keys_present(@enforce_keys)
    |> then(&struct!(__MODULE__, &1))
    |> then(&%{"params" => &1})
  end

  def get_dt_class(key) do
    if Map.has_key?(@dt_classes, key) do
      @dt_classes[key]
    else
      ""
    end
  end
end
