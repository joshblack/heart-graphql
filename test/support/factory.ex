defmodule Heart.Factory do
  use ExMachina.Ecto, repo: Heart.Repo

  alias Heart.Organization
  alias Heart.Offering
  alias Heart.Goal
  alias Heart.Signal
  alias Heart.Metric

  def organization_factory do
    %Organization{
      name: sequence("Organization"),
      description: Faker.Lorem.paragraph(),
      slug: sequence("organization"),
    }
  end

  def offering_factory do
    %Offering{
      name: sequence("Offering"),
      description: Faker.Lorem.paragraph(),
      slug: sequence("offering"),
    }
  end

  def offering_organization_factory do
    %Offering{
      name: sequence("Offering"),
      description: Faker.Lorem.paragraph(),
      slug: sequence("offering"),
      organization: build(:organization),
    }
  end

  def goal_factory do
    title = Faker.Lorem.sentence()
    slug = Slugger.slugify_downcase(title)

    %Goal{
      title: title,
      description: Faker.Lorem.paragraph(),
      slug: slug,
    }
  end

  def signal_factory do
    title = Faker.Lorem.sentence()
    slug = Slugger.slugify_downcase(title)

    %Signal{
      title: title,
      description: Faker.Lorem.paragraph(),
      slug: slug,
    }
  end

  def metric_factory do
    %Metric{
      name: sequence("metric"),
      description: Faker.Lorem.paragraph(),
      target: 25.0,
      slug: sequence("metric"),
    }
  end
end
