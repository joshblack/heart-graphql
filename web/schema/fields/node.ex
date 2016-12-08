defmodule Heart.Schema.Fields.Node do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

  alias Heart.Resolver.Offering
  alias Heart.Resolver.Organization

  object :node_field do
    node field do
      resolve fn
        %{type: :offering, id: id}, _ ->
          Offering.find(%{id: id}, %{})
        %{type: :organization, id: id}, _ ->
          Organization.find(%{id: id}, %{})
        _, _ ->
          nil
      end
    end
  end
end
