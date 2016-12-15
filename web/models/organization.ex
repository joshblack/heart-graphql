defmodule Heart.Organization do
  @moduledoc """
  Provides the Ecto Schema and corresponding Changeset for creating an
  Organization. An Organization corresponds to an IBM Organization, such as
  IBM Watson, IBM Analytics, and more.

  Organizations have a one-to-many relationship with Offerings.
  """

  use Heart.Web, :model

  schema "organizations" do
    field :name, :string
    field :description, :string
    field :slug, :string
    has_many :offerings, Heart.Offering

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description], [:slug])
    |> slugify_name()
    |> validate_required([:name, :description, :slug])
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end
end
