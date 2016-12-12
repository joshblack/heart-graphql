defmodule Heart.Metric do
  @moduledoc """
  Provides an Ecto Schema and changeset for a Metric.
  """

  use Heart.Web, :model

  schema "metrics" do
    field :name, :string
    field :description, :string
    field :target, :float
    belongs_to :signal, Heart.Signal

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :target, :signal_id])
    |> validate_required([:name, :description, :target, :signal_id])
  end
end
