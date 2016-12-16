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
  alias Heart.Resolver.Signal
  alias Heart.Resolver.Metric

  object :viewer do
    connection field :organizations, node_type: :organization do
      resolve &Organization.all/2
    end

    field :organization, type: :organization do
      arg :id, :id
      arg :slug, :string

      (&Organization.find/2)
      |> parsing_node_ids(id: :organization)
      |> resolve()
    end

    field :offering, type: :offering do
      arg :id, :id
      arg :slug, :string

      (&Offering.find/2)
      |> parsing_node_ids(id: :offering)
      |> resolve()
    end

    field :goal, type: :goal do
      arg :id, :id
      arg :goal_slug, :string
      arg :offering_slug, :string

      (&Goal.find/2)
      |> parsing_node_ids(id: :goal)
      |> resolve()
    end

    field :signal, type: :signal do
      arg :id, :id
      arg :signal_slug, :string
      arg :offering_slug, :string

      (&Signal.find/2)
      |> parsing_node_ids(id: :signal)
      |> resolve()
    end

    field :metric, type: :metric do
      arg :id, :id
      arg :metric_slug, :string
      arg :offering_slug, :string

      (&Metric.find/2)
      |> parsing_node_ids(id: :metric)
      |> resolve()
    end
  end
end
