defmodule Heart.Schema.Fields do
  use Absinthe.Schema.Notation

  import_types Heart.Schema.Fields.Node
  import_types Heart.Schema.Fields.Viewer
end
