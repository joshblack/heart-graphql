defmodule Heart.Offering do
  use Heart.Web, :model

  schema "offerings" do
    field :name, :string
    field :description, :string
    belongs_to :organization, Heart.Organization

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :organization_id])
    |> validate_required([:name, :description, :organization_id])
    |> unique_constraint(:name)
    |> foreign_key_constraint(:organization_id)
  end
end
