defmodule Heart.Repo.Migrations.AddSlugField do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :slug, :string, null: false
    end

    alter table(:offerings) do
      add :slug, :string, null: false
    end

    alter table(:goals) do
      add :slug, :string, null: false
    end

    alter table(:signals) do
      add :slug, :string, null: false
    end

    alter table(:metrics) do
      add :slug, :string, null: false
    end

    create unique_index(:organizations, [:slug])
    create unique_index(:offerings, [:slug])
  end
end
