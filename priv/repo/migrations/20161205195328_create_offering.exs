defmodule Heart.Repo.Migrations.CreateOffering do
  use Ecto.Migration

  def change do
    create table(:offerings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :text
      add :organization_id, references(:organizations, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:offerings, [:organization_id])
    create unique_index(:offerings, [:name])
  end
end
