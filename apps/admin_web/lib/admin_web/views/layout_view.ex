defmodule AdminWeb.LayoutView do
  use AdminWeb, :view

  alias AdminWeb.Router.Helpers, as: Routes
  alias AdminWeb.Endpoint

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def menu() do
    [
      %{
        label: "Dashboard",
        icon: "chart_pie",
        route: Routes.page_path(Endpoint, :index)
      }, %{
        label: "Users",
        icon: "user_group",
        route: Routes.user_path(Endpoint, :index)
      }, %{
        label: "Catalogs",
        icon: "folder_open",
        route: Routes.catalog_path(Endpoint, :index)
      }
    ]
  end
end
