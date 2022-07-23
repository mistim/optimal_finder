defmodule OptimalFinder.GoodsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OptimalFinder.Goods` context.
  """

  @doc """
  Generate a catalog.
  """
  def catalog_fixture(attrs \\ %{}) do
    {:ok, catalog} =
      attrs
      |> Enum.into(%{

      })
      |> OptimalFinder.Goods.create_catalog()

    catalog
  end
end
