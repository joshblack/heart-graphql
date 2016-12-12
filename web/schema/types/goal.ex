defmodule Heart.Schema.Types.Goal do
  @moduledoc """
  Provides a Goal Type for use in a GraphQL Schema.
  """

  use Heart.Web, :type

  node object :goal do
    @desc "The title of the goal."
    field :title, :string

    @desc "The description of the goal."
    field :description, :string

    @desc "The offering that the goal belongs to."
    field :offering, :offering, resolve: assoc(:offering)
  end

  connection node_type: :goal
end
