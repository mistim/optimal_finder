defmodule AdminWeb.CatalogController do
  use AdminWeb, :controller

  alias OptimalFinder.Goods
  alias OptimalFinder.Goods.Catalog

  def index(conn, _params) do
    # catalogs = Goods.list_catalogs()
    # render(conn, "index.html", catalogs: catalogs)

    import Ecto.Query, only: [from: 2]

    query = from(c in Catalog, select: c)
    render(conn, "index.html", query: query)
  end

  def new(conn, _params) do
    changeset = Goods.change_catalog(%Catalog{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"catalog" => catalog_params}) do
    case Goods.create_catalog(catalog_params) do
      {:ok, catalog} ->
        conn
        |> put_flash(:info, "Catalog created successfully.")
        |> redirect(to: Routes.catalog_path(conn, :show, catalog))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    catalog = Goods.get_catalog!(id)
    render(conn, "show.html", catalog: catalog)
  end

  def edit(conn, %{"id" => id}) do
    catalog = Goods.get_catalog!(id)
    changeset = Goods.change_catalog(catalog)
    render(conn, "edit.html", catalog: catalog, changeset: changeset)
  end

  def update(conn, %{"id" => id, "catalog" => catalog_params}) do
    catalog = Goods.get_catalog!(id)

    case Goods.update_catalog(catalog, catalog_params) do
      {:ok, catalog} ->
        conn
        |> put_flash(:info, "Catalog updated successfully.")
        |> redirect(to: Routes.catalog_path(conn, :show, catalog))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", catalog: catalog, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    catalog = Goods.get_catalog!(id)
    {:ok, _catalog} = Goods.delete_catalog(catalog)

    conn
    |> put_flash(:info, "Catalog deleted successfully.")
    |> redirect(to: Routes.catalog_path(conn, :index))
  end
end
