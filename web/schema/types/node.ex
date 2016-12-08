defmodule Heart.Schema.Types.Node do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation

  node interface do
    resolve_type fn
      %Heart.Offering{}, _ -> :offering
      %Heart.Organization{}, _ -> :organization
      _, _ -> nil
    end
  end
end
