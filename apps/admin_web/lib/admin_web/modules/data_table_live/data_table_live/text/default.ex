defmodule DataTableLive.Text.Default do
  @moduledoc "Default text for the DataTableLive HTML interface"
  @behaviour DataTableLive.Text

  # Action buttons

  @impl DataTableLive.Text
  def actions(_assigns), do: "Actions"
  @impl DataTableLive.Text
  def new(_assigns), do: "New"
  @impl DataTableLive.Text
  def show(_assigns), do: "Show"
  @impl DataTableLive.Text
  def edit(_assigns), do: "Edit"
  @impl DataTableLive.Text
  def delete(_assigns), do: "Delete"
  @impl DataTableLive.Text
  def confirm_action(_assigns), do: "Are you sure?"

  # Pagination

  @impl DataTableLive.Text
  def previous(_assigns), do: "Previous"
  @impl DataTableLive.Text
  def next(_assigns), do: "Next"

  # Search

  @impl DataTableLive.Text
  def search(_assigns), do: "Search"
  @impl DataTableLive.Text
  def nothing_found(_assigns), do: "Nothing found"

  # Show and hide fields

  @impl DataTableLive.Text
  def show_field_buttons(_assigns), do: "Show Field Buttons"
  @impl DataTableLive.Text
  def hide_field_buttons(_assigns), do: "Hide Field Buttons"
  @impl DataTableLive.Text
  def show_field(_assigns, field), do: "Show #{field}"
  @impl DataTableLive.Text
  def hide(_assigns), do: "hide"
  @impl DataTableLive.Text
  def sort(_assigns), do: "sort"
end
