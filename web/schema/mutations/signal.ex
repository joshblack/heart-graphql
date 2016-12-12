defmodule Heart.Schema.Mutations.Signal do
  @moduledoc """
  Provides Relay-compliant mutation fields surrounding our Signal type to use
  in our Root Mutation Type.
  """

  use Heart.Web, :type

  alias Heart.Resolver.Signal

  object :signal_mutations do
    payload field :create_signal do
      input do
        field :title, non_null(:string)
        field :description, :string
        field :goal_id, non_null(:id)
      end

      output do
        field :signal, :signal
      end

      (&Signal.create/2)
      |> parsing_node_ids(goal_id: :goal)
      |> resolve()
    end

    payload field :update_signal do
      input do
        field :id, non_null(:id)
        field :title, :string
        field :description, :string
      end

      output do
        field :signal, :signal
      end

      (&Signal.update/2)
      |> parsing_node_ids(id: :signal)
      |> resolve()
    end

    payload field :remove_signal do
      input do
        field :id, non_null(:id)
      end

      output do
        field :signal, :signal
      end

      (&Signal.delete/2)
      |> parsing_node_ids(id: :signal)
      |> resolve()
    end
  end
end
