defmodule Heart.Schema.Types.Metric do
  @moduledoc """
  Provides a Metric Type for use in a GraphQL Schema.
  """

  use Heart.Web, :type

  node object :metric do
    @desc "The name of the metric."
    field :name, non_null(:string)

    @desc "The description of the metric."
    field :description, non_null(:string)

    @desc "The target number for the metric."
    field :target, non_null(:float)

    @desc "The slug for the metric URL."
    field :slug, non_null(:string)

    @desc "The signal that the metric belongs to."
    field :signal, non_null(:signal), resolve: assoc(:signal)
  end

  connection node_type: :metric
end
