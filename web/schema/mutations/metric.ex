defmodule Heart.Schema.Mutations.Metric do
  @moduledoc """
  Provides Relay-compliant mutation fields surrounding our Metric type to use
  in our Root Mutation Type.
  """

  use Heart.Web, :type

  alias Heart.Resolver.Metric

  object :metric_mutations do
    payload field :create_metric do
      input do
        field :name, non_null(:string)
        field :description, non_null(:string)
        field :target, non_null(:float)
        field :signal_id, non_null(:id)
      end

      output do
        field :metric, :metric
      end

      (&Metric.create/2)
      |> parsing_node_ids(signal_id: :signal)
      |> resolve()
    end

    payload field :update_metric do
      input do
        field :id, non_null(:id)
        field :name, :string
        field :description, :string
        field :target, :float
      end

      output do
        field :metric, :metric
      end

      (&Metric.update/2)
      |> parsing_node_ids(id: :metric)
      |> resolve()
    end

    payload field :remove_metric do
      input do
        field :id, non_null(:id)
      end

      output do
        field :metric, :metric
      end

      (&Metric.delete/2)
      |> parsing_node_ids(id: :metric)
      |> resolve()
    end
  end
end
