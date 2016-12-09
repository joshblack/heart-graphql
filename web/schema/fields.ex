defmodule Heart.Schema.Fields do
  @moduledoc """
  Provides access to all the Fields that we've defined for our Root Query Type.
  """

  use Absinthe.Schema.Notation

  import_types Heart.Schema.Fields.Node
  import_types Heart.Schema.Fields.Viewer
end
