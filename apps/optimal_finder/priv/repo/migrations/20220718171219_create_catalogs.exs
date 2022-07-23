defmodule OptimalFinder.Repo.Migrations.CreateCatalogs do
  use Ecto.Migration

  def change do
    create table(:catalogs) do
      add :name, :string, null: false, size: 160, unique: true
      add :singular_name, :string, null: false, size: 160
      add :status, :integer
      add :type, :integer
      add :parent_id, :id
      add :lft, :integer
      add :rgt, :integer
      add :creator_id, references(:users)
      add :editor_id, references(:users)
      timestamps()
    end
  end
end
