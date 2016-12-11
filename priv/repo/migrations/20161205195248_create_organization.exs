defmodule Heart.Repo.Migrations.CreateOrganization do
  use Ecto.Migration

  def change do
    create table(:organizations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:organizations, [:name])
  end
end
