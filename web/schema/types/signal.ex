defmodule Heart.Schema.Types.Signal do
  @moduledoc """
  Provides a Signal Type for use in a GraphQL Schema.
  """

  use Heart.Web, :type

  alias Heart.Resolver.Signal

  node object :signal do
    @desc "The title of the signal."
    field :title, non_null(:string)

    @desc "The description of the signal."
    field :description, non_null(:string)

    @desc "The slug for the signal URL."
    field :slug, non_null(:string)

    @desc "The goal that the signal belongs to."
    field :goal, non_null(:goal), resolve: assoc(:goal)

    @desc "The metrics that fall under the signal."
    connection field :metrics, node_type: :metric do
      resolve &Signal.metrics/2
    end
  end

  connection node_type: :signal
end
