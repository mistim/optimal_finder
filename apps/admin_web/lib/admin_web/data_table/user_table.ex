defmodule AdminWeb.DataTable.UserTable do

  import Ecto.Query, only: [from: 2]

  alias AdminWeb.Router.Helpers, as: Routes
  alias Admin.Accounts.User

  use DataTableLive,
  repo: Admin.Repo,
  routes: Routes,
  path: :user_path,
  action_buttons: [],
  query: from(u in User),
  fields: [
    email: [label: "Email"],
    confirmed_at: [label: "Confirmed"],
    #summary: [label: "Summary", hidden: true]
  ],
  pagination: [:top, :bottom],
  per_page: 10

  def render(assigns) do
    ~H"<%= build_table(assigns) %>"
  end

end
