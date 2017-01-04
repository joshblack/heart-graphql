defmodule Heart.Schema.Types do
  @moduledoc """
  Provides access to all the types that we've defined in our Schema for use in
  Queries, Mutations, and Subscriptions.
  """

  use Heart.Web, :type

  import_types Heart.Schema.Types.Node
  import_types Heart.Schema.Types.Viewer
  import_types Heart.Schema.Types.Organization
  import_types Heart.Schema.Types.Offering
  import_types Heart.Schema.Types.Goal
  import_types Heart.Schema.Types.Signal
  import_types Heart.Schema.Types.Metric
  import_types Heart.Schema.Types.Enums
end
