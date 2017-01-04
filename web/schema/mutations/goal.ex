defmodule Heart.Schema.Mutations.Goal do
  @moduledoc """
  Provides Relay-compliant mutation fields surrounding our Goal type to use
  in our Root Mutation Type.
  """

  use Heart.Web, :type

  alias Heart.Resolver.Goal

  object :goal_mutations do
    payload field :create_goal do
      input do
        field :title, non_null(:string)
        field :description, :string
        field :offering_id, non_null(:id)
      end

      output do
        field :offering, :offering
        field :new_goal_edge, :goal_edge
      end

      (&Goal.create/2)
      |> parsing_node_ids(offering_id: :offering)
      |> resolve()
    end

    payload field :update_goal do
      input do
        field :id, non_null(:id)
        field :title, :string
        field :description, :string
      end

      output do
        field :goal, :goal
      end

      (&Goal.update/2)
      |> parsing_node_ids(id: :goal)
      |> resolve()
    end

    payload field :remove_goal do
      input do
        field :id, non_null(:id)
      end

      output do
        field :goal, :goal
      end

      (&Goal.delete/2)
      |> parsing_node_ids(id: :goal)
      |> resolve()
    end
  end
end
