defmodule Heart.Schema.Types.Viewer do
  @moduledoc """
  Provides a Root Viewer Type for use in a GraphQL Schema. This is helpful when
  working with Relay-specific clients since fragments will be based off of this
  Viewer Type.
  """

  use Heart.Web, :type

  alias Heart.Resolver.Organization
  alias Heart.Resolver.Offering
  alias Heart.Resolver.Goal

  object :viewer do
    connection field :organizations, node_type: :organization do
      resolve &Organization.all/2
    end

    field :organization, type: :organization do
      arg :id, non_null(:id)

      (&Organization.find/2)
      |> parsing_node_ids(id: :organization)
      |> resolve()
    end

    field :offering, type: :offering do
      arg :id, non_null(:id)

      (&Offering.find/2)
      |> parsing_node_ids(id: :offering)
      |> resolve()
    end

    field :goal, type: :goal do
      arg :id, non_null(:id)

      (&Goal.find/2)
      |> parsing_node_ids(id: :goal)
      |> resolve()
    end
  end
end
