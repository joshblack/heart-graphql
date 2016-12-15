defmodule Heart.Schema.Types.Goal do
  @moduledoc """
  Provides a Goal Type for use in a GraphQL Schema.
  """

  use Heart.Web, :type

  alias Heart.Resolver.Goal

  node object :goal do
    @desc "The title of the goal."
    field :title, non_null(:string)

    @desc "The description of the goal."
    field :description, non_null(:string)

    @desc "The slug for the goal URL."
    field :slug, non_null(:string)

    @desc "The offering that the goal belongs to."
    field :offering, non_null(:offering), resolve: assoc(:offering)

    @desc "The signals that fall under a goal"
    connection field :signals, node_type: :signal do
      resolve &Goal.signals/2
    end
  end

  connection node_type: :goal
end
