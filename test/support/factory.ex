defmodule Heart.Factory do
  use ExMachina.Ecto, repo: Heart.Repo

  alias Heart.Organization
  alias Heart.Offering

  def organization_factory do
    %Organization{
      name: sequence("Organization"),
      description: "An IBM Organization.",
    }
  end

  def offering_factory do
    %Offering {
      name: sequence("Offering"),
      description: "An IBM Offering.",
    }
  end

  def offering_organization_factory do
    %Offering {
      name: sequence("Offering"),
      description: "An IBM Offering.",
      organization: build(:organization),
    }
  end
end
