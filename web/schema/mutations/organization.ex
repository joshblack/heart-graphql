defmodule Heart.Schema.Mutations.Organization do
  @moduledoc """
  Provides Relay-compliant mutation fields surrounding our Organization type to
  use in our Root Mutation Type.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

  alias Heart.Resolver.Organization

  object :organization_mutations do
    payload field :create_organization do
      input do
        field :name, non_null(:string)
        field :description, non_null(:string)
      end

      output do
        field :viewer, :viewer
        field :new_organization_edge, :organization_edge
      end

      resolve &Organization.create/2
    end

    payload field :update_organization do
      input do
        field :name, non_null(:string)
        field :description, non_null(:string)
        field :id, non_null(:id)
      end

      output do
        field :organization, :organization
      end

      (&Organization.update/2)
      |> parsing_node_ids(id: :organization)
      |> resolve()
    end

    payload field :remove_organization do
      input do
        field :id, non_null(:id)
      end

      output do
        field :organization, :organization
      end

      (&Organization.delete/2)
      |> parsing_node_ids(id: :organization)
      |> resolve()
    end
  end
end
