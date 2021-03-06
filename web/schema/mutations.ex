defmodule Heart.Schema.Mutations do
  @moduledoc """
  Provides access to all the mutations that we've defined for our Root
  Mutation Type.
  """

  use Absinthe.Schema.Notation

  import_types Heart.Schema.Mutations.Organization
  import_types Heart.Schema.Mutations.Offering
  import_types Heart.Schema.Mutations.Goal
  import_types Heart.Schema.Mutations.Signal
  import_types Heart.Schema.Mutations.Metric
  import_types Heart.Schema.Mutations.Event
end
