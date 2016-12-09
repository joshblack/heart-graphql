defmodule Heart.Schema.Types.Organization do
  @moduledoc """
  Provides an Organization Type for use in a GraphQL Schema.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

  use Absinthe.Ecto, repo: Heart.Repo

  @desc """
  An organization that exists within IBM. For example, IBM Watson or Analytics.
  """
  node object :organization do
    @desc "The name of the organization."
    field :name,  :string

    @desc "The description for the organization."
    field :description, :string

    @desc "The offerings that fall under this organization."
    field :offerings, list_of(:offering), resolve: assoc(:offerings)
  end

  connection node_type: :organization
end
