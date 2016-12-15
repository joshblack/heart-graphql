defmodule Heart.Goal do
  @moduledoc """
  Provides an Ecto Schema and changeset for a Goal. A Goal belongs to an
  Offering, and represents a high-level objective to try and achieve as a
  group.
  """

  use Heart.Web, :model

  schema "goals" do
    field :title, :string
    field :description, :string
    field :slug, :string
    has_many :signals, Heart.Signal
    belongs_to :offering, Heart.Offering

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :offering_id], [:slug])
    |> slugify_title()
    |> validate_required([:title, :description, :slug, :offering_id])
    |> foreign_key_constraint(:offering_id)
  end
end
