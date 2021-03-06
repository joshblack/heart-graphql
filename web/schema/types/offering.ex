defmodule Heart.Schema.Types.Offering do
  @moduledoc """
  Provides an Offering Type for use in a GraphQL Schema.
  """

  use Heart.Web, :type

  alias Heart.Resolver.Offering

  @desc """
  An offering that exists within an IBM organization. For example, Watson
  Virtual Agent.
  """
  node object :offering do
    @desc "The name of the offering."
    field :name, non_null(:string)

    @desc "The description for the offering."
    field :description, non_null(:string)

    @desc "The slug for the offering URL."
    field :slug, non_null(:string)

    @desc "The organization that the offering belongs to."
    field :organization, non_null(:organization), resolve: assoc(:organization)

    @desc "The goals that fall under an offering."
    connection field :goals, node_type: :goal do
      resolve &Offering.goals/2
    end
  end

  connection node_type: :offering
end
