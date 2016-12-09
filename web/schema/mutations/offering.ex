defmodule Heart.Schema.Mutations.Offering do
  @moduledoc """
  Provides Relay-compliant mutation fields surrounding our Offering type to use
  in our Root Mutation Type.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

  alias Heart.Resolver.Offering

  object :offering_mutations do
    payload field :create_offering do
      input do
        field :name, non_null(:string)
        field :description, non_null(:string)
        field :organization_id, non_null(:id)
      end

      output do
        field :offering, :offering
      end

      (&Offering.create/2)
      |> parsing_node_ids(organization_id: :organization)
      |> resolve()
    end
  end
end
