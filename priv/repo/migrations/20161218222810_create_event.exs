defmodule Heart.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :value, :float, null: false
      add :properties, :map
      add :inserted_at, :datetime
      add :metric_id, references(:metrics, on_delete: :delete_all, type: :binary_id)
    end

    create index(:events, [:metric_id])
  end
end
