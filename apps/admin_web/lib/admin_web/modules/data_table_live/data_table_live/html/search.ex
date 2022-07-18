defmodule DataTableLive.HTML.Search do
  @moduledoc "Build the search field part of the HTML"

  alias DataTableLive.HTML.Helpers
  alias DataTableLive.{Params, Text}
  alias Phoenix.HTML.Form

  @doc "Returns the HTML search form"
  @spec build(map) :: {:safe, iolist}
  def build(%{params: %Params{debounce: debounce} = params}) do
    if search_enabled?(params) do
      Form.form_for(
        :search,
        "#",
        # onkeypress to disable enter key in search field
        [
          phx_change: :search,
          class: Params.get_dt_class(:search_form),
          onkeypress: "return event.keyCode != 13;"
        ],
        fn f ->
          [
            Form.text_input(f, :search,
              placeholder: Text.text(params, :search),
              class: Params.get_dt_class(:search_field),
              phx_debounce: debounce
            ),
            counter(params)
          ]
          |> Helpers.tag(:div, class: Params.get_dt_class(:search_field_wrapper))
        end
      )
      |> Helpers.tag(:div, class: Params.get_dt_class(:search_wrapper))
    else
      {:safe, [""]}
    end
  end

  defp counter(%Params{count: count}) do
    count
    |> Helpers.tag(:div, class: Params.get_dt_class(:counter_field))
    |> Helpers.tag(:div, class: Params.get_dt_class(:counter_field_wrapper))
  end

  # Returns true if any of the fields have search enabled
  defp search_enabled?(%Params{fields: fields}) do
    fields
    |> Enum.filter(fn {_k, field} -> Map.get(field, :search) end)
    |> Enum.any?()
  end
end
