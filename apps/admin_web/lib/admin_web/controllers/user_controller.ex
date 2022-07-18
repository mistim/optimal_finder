defmodule AdminWeb.UserController do
  use AdminWeb, :controller

  alias Admin.Accounts.User

  def index(conn, _params) do
    import Ecto.Query, only: [from: 2]

    query = from(u in User, select: u)
    render(conn, "index.html", query: query)
  end
end
