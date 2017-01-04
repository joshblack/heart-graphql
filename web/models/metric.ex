defmodule Heart.Metric do
  @moduledoc """
  Provides an Ecto Schema and changeset for a Metric.
  """

  use Heart.Web, :model

  schema "metrics" do
    field :name, :string
    field :description, :string
    field :target, :float
    field :slug, :string

    # TODO: Metrics <-> Offering (many-to-many)
    belongs_to :signal, Heart.Signal
    has_many :events, Heart.Event

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :target, :signal_id], [:slug])
    |> slugify_name()
    |> validate_required([:name, :description, :target, :slug, :signal_id])
  end
end
