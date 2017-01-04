defmodule Heart.Repo.Migrations.CreateGoal do
  use Ecto.Migration

  def change do
    create table(:goals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :offering_id, references(:offerings, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:goals, [:offering_id])
  end
end
