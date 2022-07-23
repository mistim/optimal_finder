defmodule OptimalFinder.Goods.Catalog do
  use Ecto.Schema
  use AsNestedSet, scope: [:id]
  import Ecto.Changeset
  alias Admin.User

  schema "catalogs" do
    field :name, :string
    field :singular_name, :string
    field :status, Ecto.Enum, values: [inactive: 0, active: 1]
    field :type, Ecto.Enum, values: [none: 0, desc: 1, no_desc: 2, half_desc: 3]
    field :parent_id
    field :lft
    field :rgt
    belongs_to :creator, User, foreign_key: :creator_id
    belongs_to :editor, User, foreign_key: :editor_id

    timestamps()
  end

  @doc false
  def changeset(catalog, attrs) do
    IO.inspect(attrs)
    catalog
    |> cast(attrs, [:name, :singular_name, :status, :type, :parent_id, :lft, :rgt, :creator_id, :editor_id])
    |> validation_name()
    |> validation_singular_name()
    # |> validate_inclusion(:status, 0..1)
    # |> validate_inclusion(:type, 0..3)
    # |> validate_number(:status, greater_than_or_equal_to: 0, message: "error 0")
    # |> validate_number(:status, less_than_or_equal_to: 2, message: "error 1")
    # |> validate_number(:type, greater_than_or_equal_to: 0)
    # |> validate_number(:type, less_than_or_equal_to: 3)
  end

  defp validation_name(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, max: 160)
    |> unique_constraint(:name)
  end

  defp validation_singular_name(changeset) do
    changeset
    |> validate_required([:singular_name])
    |> validate_length(:singular_name, max: 160)
    |> unique_constraint(:singular_name)
  end
end
