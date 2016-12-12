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
    belongs_to :offering, Heart.Offering

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :offering_id])
    |> validate_required([:title, :description, :offering_id])
    |> foreign_key_constraint(:offering_id)
  end
end
