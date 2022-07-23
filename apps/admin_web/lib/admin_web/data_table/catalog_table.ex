defmodule AdminWeb.DataTable.CatalogTable do

  import Ecto.Query, only: [from: 2]

  alias AdminWeb.Router.Helpers, as: Routes
  alias OptimalFinder.Goods.Catalog

  use DataTableLive,
  repo: OptimalFinder.Repo,
  routes: Routes,
  path: :catalog_path,
  action_buttons: [:new, :show, :edit, :delete],
  query: from(c in Catalog),
  fields: [
    name: [label: "Name"],
    singular_name: [label: "Singular name"],
    status: [lbel: "Status"],
    type: [label: "Type"]
    #summary: [label: "Summary", hidden: true]
  ],
  pagination: [:top, :bottom],
  per_page: 10

  def render(assigns) do
    ~H"<%= build_table(assigns) %>"
  end

end
