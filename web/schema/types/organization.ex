defmodule Heart.Schema.Types.Organization do
  @moduledoc """
  Provides an Organization Type for use in a GraphQL Schema.
  """

  use Heart.Web, :type

  alias Heart.Resolver.Organization

  @desc """
  An organization that exists within IBM. For example, IBM Watson or Analytics.
  """
  node object :organization do
    @desc "The name of the organization."
    field :name,  non_null(:string)

    @desc "The description for the organization."
    field :description, non_null(:string)

    @desc "The slug for the organization URL."
    field :slug, non_null(:string)

    @desc "The offerings that fall under this organization."
    connection field :offerings, node_type: :offering do
      resolve &Organization.offerings/2
    end
  end

  connection node_type: :organization
end
