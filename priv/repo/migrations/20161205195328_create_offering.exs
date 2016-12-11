defmodule Heart.Repo.Migrations.CreateOffering do
  use Ecto.Migration

  def change do
    create table(:offerings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :organization_id, references(:organizations, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:offerings, [:organization_id])
    create unique_index(:offerings, [:name])
  end
end
