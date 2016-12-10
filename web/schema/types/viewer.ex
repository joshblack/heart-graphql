defmodule Heart.Schema.Types.Viewer do
  @moduledoc """
  Provides a Root Viewer Type for use in a GraphQL Schema. This is helpful when
  working with Relay-specific clients since fragments will be based off of this
  Viewer Type.
  """

  # Provides us with a DSL for defining GraphQL Types
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

  # Enable helpers for batching associated requests
  use Absinthe.Ecto, repo: Heart.Repo

  alias Heart.Resolver.Organization
  alias Heart.Resolver.Offering

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

    connection field :offerings, node_type: :offering do
      resolve &Offering.all/2
    end

    field :offering, type: :offering do
      arg :id, non_null(:id)

      (&Offering.find/2)
      |> parsing_node_ids(id: :offering)
      |> resolve()
    end
  end
end
