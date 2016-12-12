defmodule Heart.Signal do
  @moduledoc """
  Provides an Ecto Schema and changeset for a Signal. A Signal belongs to a Goal
  and provides an indicator for whether or not the metrics composing the signal
  are positive or not.
  """

  use Heart.Web, :model

  schema "signals" do
    field :title, :string
    field :description, :string
    belongs_to :goal, Heart.Goal
    has_many :metrics, Heart.Metric

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :goal_id])
    |> validate_required([:title, :description, :goal_id])
    |> foreign_key_constraint(:goal_id)
  end
end
