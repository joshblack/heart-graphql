defmodule Heart.Repo.Migrations.CreateSignal do
  use Ecto.Migration

  def change do
    create table(:signals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :goal_id, references(:goals, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:signals, [:goal_id])
  end
end
