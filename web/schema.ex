defmodule Heart.Schema do
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
    # create_resource_mutation
    # edit_resource_mutation
    # delete_resource_mutation

    import_fields :offering_mutations
  end
end
