defmodule Heart.Schema.Types do
  @moduledoc """
  Provides access to all the types that we've defined in our Schema for use in
  Queries, Mutations, and Subscriptions.
  """

  use Absinthe.Schema.Notation

  import_types Heart.Schema.Types.Node
  import_types Heart.Schema.Types.Viewer
  import_types Heart.Schema.Types.Organization
  import_types Heart.Schema.Types.Offering
end
