# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Heart.Repo.insert!(%Heart.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Heart.Organization
alias Heart.Offering
alias Heart.Goal
alias Heart.Signal
alias Heart.Metric

organization = Organization.changeset(%Organization{}, %{
  name: "IBM Watson",
  description: "An organization within IBM"
})

organization = Heart.Repo.insert!(organization)

offering = Offering.changeset(%Offering{}, %{
  name: "Watson Virtual Agent",
  description: "An IBM Watson Offering.",
  organization_id: organization.id,
})

offering = Heart.Repo.insert!(offering)

goal = Goal.changeset(%Goal{}, %{
  title: "Performance",
  description: "Performance-related items.",
  offering_id: offering.id,
})

goal = Heart.Repo.insert!(goal)

signal = Signal.changeset(%Signal{}, %{
  title: "Browser",
  description: "Browser-related performance items.",
  goal_id: goal.id,
})

signal = Heart.Repo.insert!(signal)

metric = Metric.changeset(%Metric{}, %{
  name: "Browser Request Time",
  description: "How long it takes for the browser to complete a request.",
  target: 3000,
  signal_id: signal.id,
})

metric = Heart.Repo.insert!(metric)

# defmodule Heart.Seeds do
  # @moduledoc """
  # Create a Custom Seeds module to utilize our Factories defined through
  # ExMachina and Seed our Database that way.
  # """

  # use ExMachina.Ecto, repo: Heart.Repo

  # import Heart.Factory

  # alias Heart.Factory

  # @num_organizations 5
  # @num_offerings 15
  # @num_goals 5
  # @num_signals 10

  # def seed do
    # offerings
    # |> Enum.chunk(@num_offerings)
    # |> Enum.each(fn offering_slice ->
      # Factory.insert(:organization, %{
        # offerings: offering_slice,
      # })
    # end)
  # end

  # def offerings do
    # Factory.build_list(@num_offerings * @num_organizations, :offering, %{
      # goals: goals
    # })
  # end

  # def goals do
    # Factory.build_list(@num_goals, :goal, %{
      # signals: signals
    # })
  # end

  # def signals do
    # Factory.build_list(@num_signals, :signal)
  # end
# end

# Heart.Seeds.seed()
