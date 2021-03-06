defmodule Heart.Offering do
  @moduledoc """
  Provides an Ecto Schema and changeset for an Offering. An Offering represents
  an individual Product, or set of Products, that exists within an IBM
  Organization.

  For example, IBM Watson has an Offering called Watson Virtual Agent.
  """

  use Heart.Web, :model

  schema "offerings" do
    field :name, :string
    field :description, :string
    field :slug, :string

    has_many :goals, Heart.Goal
    has_many :signals, through: [:goals, :signals]
    has_many :metrics, through: [:goals, :signals, :metrics]
    belongs_to :organization, Heart.Organization

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :organization_id], [:slug])
    |> slugify_name()
    |> validate_required([:name, :description, :slug, :organization_id])
    |> unique_constraint(:name)
    |> foreign_key_constraint(:organization_id)
  end
end
