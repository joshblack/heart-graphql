defmodule Heart.Schema.Mutations.Offering do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

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

      (&Heart.Resolver.Offering.create/2)
      |> parsing_node_ids(organization_id: :organization)
      |> resolve()
    end
  end
end
