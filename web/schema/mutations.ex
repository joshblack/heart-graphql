defmodule Heart.Schema.Mutations do
  @moduledoc """
  Provides access to all the mutations that we've defined for our Root
  Mutation Type.
  """

  use Absinthe.Schema.Notation

  import_types Heart.Schema.Mutations.Offering
end
