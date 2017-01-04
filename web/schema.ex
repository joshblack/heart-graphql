defmodule Heart.Schema do
  @moduledoc """
  The GraphQL Schema for Heart that imports all the Types, Fields, and Mutations
  and imports the specific fields from each for our Root Query Type and Root
  Mutation Type.
  """

  use Absinthe.Schema
  use Absinthe.Relay.Schema

  import_types Heart.Schema.Types
  import_types Heart.Schema.Fields
  import_types Heart.Schema.Mutations

  query do
    import_fields :node_field
    import_fields :viewer_field
  end

  mutation do
    import_fields :organization_mutations
    import_fields :offering_mutations
    import_fields :goal_mutations
    import_fields :signal_mutations
    import_fields :metric_mutations
    import_fields :event_mutations
  end
end
