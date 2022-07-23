defmodule OptimalFinder.GoodsTest do
  use OptimalFinder.DataCase

  alias OptimalFinder.Goods

  describe "catalogs" do
    alias OptimalFinder.Goods.Catalog

    import OptimalFinder.GoodsFixtures

    @invalid_attrs %{}

    test "list_catalogs/0 returns all catalogs" do
      catalog = catalog_fixture()
      assert Goods.list_catalogs() == [catalog]
    end

    test "get_catalog!/1 returns the catalog with given id" do
      catalog = catalog_fixture()
      assert Goods.get_catalog!(catalog.id) == catalog
    end

    test "create_catalog/1 with valid data creates a catalog" do
      valid_attrs = %{}

      assert {:ok, %Catalog{} = catalog} = Goods.create_catalog(valid_attrs)
    end

    test "create_catalog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goods.create_catalog(@invalid_attrs)
    end

    test "update_catalog/2 with valid data updates the catalog" do
      catalog = catalog_fixture()
      update_attrs = %{}

      assert {:ok, %Catalog{} = catalog} = Goods.update_catalog(catalog, update_attrs)
    end

    test "update_catalog/2 with invalid data returns error changeset" do
      catalog = catalog_fixture()
      assert {:error, %Ecto.Changeset{}} = Goods.update_catalog(catalog, @invalid_attrs)
      assert catalog == Goods.get_catalog!(catalog.id)
    end

    test "delete_catalog/1 deletes the catalog" do
      catalog = catalog_fixture()
      assert {:ok, %Catalog{}} = Goods.delete_catalog(catalog)
      assert_raise Ecto.NoResultsError, fn -> Goods.get_catalog!(catalog.id) end
    end

    test "change_catalog/1 returns a catalog changeset" do
      catalog = catalog_fixture()
      assert %Ecto.Changeset{} = Goods.change_catalog(catalog)
    end
  end
end
