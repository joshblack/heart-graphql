defmodule Heart.Schema.Types.Node do
  @moduledoc """
  Provides a Node Type for use in a GraphQL Schema. This is required by any
  Relay-compliant server as Relay needs to refetch items by a base64-encoded
  id.
  """

  use Heart.Web, :type

  node interface do
    resolve_type fn
      %Heart.Offering{}, _ -> :offering
      %Heart.Organization{}, _ -> :organization
      %Heart.Goal{}, _ -> :goal
      _, _ -> nil
    end
  end
end
