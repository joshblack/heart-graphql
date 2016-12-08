defmodule Heart.Organization do
  use Heart.Web, :model

  schema "organizations" do
    field :name, :string
    field :description, :string
    has_many :offerings, Heart.Offering

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
