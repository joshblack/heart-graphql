defmodule Heart.Event do
  use Heart.Web, :model

  @primary_key {:id, :id, autogenerate: true}

  schema "events" do
    field :value, :float
    field :labels, :string
    field :properties, :map

    belongs_to :metric, Heart.Metric

    timestamps(updated_at: false)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:value, :properties, :metric_id])
    |> validate_required([:value, :metric_id])
  end
end
