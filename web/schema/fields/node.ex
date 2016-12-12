defmodule Heart.Schema.Fields.Node do
  @moduledoc """
  Provides a Relay-compliant Node field used for re-fetching an item by it's
  base64-encoded ID.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

  alias Heart.Resolver.Offering
  alias Heart.Resolver.Organization
  alias Heart.Resolver.Goal
  alias Heart.Resolver.Signal
  alias Heart.Resolver.Metric

  object :node_field do
    node field do
      resolve fn
        %{type: :offering, id: id}, _ ->
          Offering.find(%{id: id}, %{})
        %{type: :organization, id: id}, _ ->
          Organization.find(%{id: id}, %{})
        %{type: :goal, id: id}, _ ->
          Goal.find(%{id: id}, %{})
        %{type: :signal, id: id}, _ ->
          Signal.find(%{id: id}, %{})
        %{type: :metric, id: id}, _ ->
          Metric.find(%{id: id}, %{})
        _, _ ->
          nil
      end
    end
  end
end
