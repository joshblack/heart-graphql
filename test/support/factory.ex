defmodule Heart.Factory do
  use ExMachina.Ecto, repo: Heart.Repo

  alias Heart.Organization

  def organization_factory do
    %Organization{
      name: "Organization",
      description: "An IBM Organization.",
    }
  end
end
