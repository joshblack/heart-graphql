defmodule Heart.Schema.Mutations.Event do
  @moduledoc """
  Provides Relay-compliant mutation fields surrounding our Event type to use
  in our Root Mutation Type.
  """

  use Heart.Web, :type

  alias Heart.Resolver.Event

  object :event_mutations do
    payload field :create_event do
      input do
        field :type, non_null(:string)
        field :value, non_null(:float)
        field :properties, :string
        field :offering_id, non_null(:id)
      end

      output do
        field :id, non_null(:id)
      end

      resolve &Event.create/2
    end
  end
end
