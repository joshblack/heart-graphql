defmodule Heart.Repo.Migrations.CreateMetric do
  use Ecto.Migration

  def change do
    create table(:metrics, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :text, null: false
      add :target, :float, null: false
      add :signal_id, references(:signals, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:metrics, [:signal_id])
  end
end
