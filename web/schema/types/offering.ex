defmodule Heart.Schema.Types.Offering do
  @moduledoc """
  Provides an Offering Type for use in a GraphQL Schema.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation
  use Absinthe.Ecto, repo: Heart.Repo

  @desc """
  An offering that exists within an IBM organization. For example, Watson
  Virtual Agent.
  """
  node object :offering do
    @desc "The name of the offering."
    field :name, :string

    @desc "The description for the offering."
    field :description, :string

    @desc "The organization that the offering belongs to."
    field :organization, :organization, resolve: assoc(:organization)
  end

  connection node_type: :offering
end
