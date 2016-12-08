defmodule Heart.Schema.Types.Viewer do
  # Provides us with a DSL for defining GraphQL Types
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

  # Enable helpers for batching associated requests
  use Absinthe.Ecto, repo: Heart.Repo

  object :viewer do
    connection field :organizations, node_type: :organization do
      resolve &Heart.Resolver.Organization.all/2
    end

    connection field :offerings, node_type: :offering do
      resolve &Heart.Resolver.Offering.all/2
    end

    field :offering, type: :offering do
      arg :id, non_null(:id)

      (&Heart.Resolver.Offering.find/2)
      |> parsing_node_ids(id: :offering)
      |> resolve()
    end
  end
end
