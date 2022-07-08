defmodule OptimalFinderWeb.PageController do
  use OptimalFinderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
