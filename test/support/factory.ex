defmodule Heart.Factory do
  use ExMachina.Ecto, repo: Heart.Repo

  alias Heart.Organization
  alias Heart.Offering
  alias Heart.Goal

  def organization_factory do
    %Organization{
      name: sequence("Organization"),
      description: Faker.Lorem.paragraph(),
    }
  end

  def offering_factory do
    %Offering {
      name: sequence("Offering"),
      description: Faker.Lorem.paragraph(),
    }
  end

  def offering_organization_factory do
    %Offering {
      name: sequence("Offering"),
      description: Faker.Lorem.paragraph(),
      organization: build(:organization),
    }
  end

  def goal_factory do
    %Goal {
      title: Faker.Lorem.sentence(),
      description: Faker.Lorem.paragraph(),
    }
  end
end
