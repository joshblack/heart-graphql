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

defmodule Heart.Seeds do
  @moduledoc """
  Create a Custom Seeds module to utilize our Factories defined through
  ExMachina and Seed our Database that way.
  """

  use ExMachina.Ecto, repo: Heart.Repo

  import Heart.Factory

  alias Heart.Factory

  @num_organizations 5
  @num_offerings 15
  @num_goals 5
  @num_signals 10
  @num_metrics 5

  def seed do
    offerings
    |> Enum.chunk(@num_offerings)
    |> Enum.each(fn offering_slice ->
      Factory.insert(:organization, %{
        offerings: offering_slice,
      })
    end)
  end

  def offerings do
    Factory.build_list(@num_offerings * @num_organizations, :offering, %{
      goals: goals
    })
  end

  def goals do
    Factory.build_list(@num_goals, :goal, %{
      signals: signals
    })
  end

  def signals do
    Factory.build_list(@num_signals, :signal, %{
      metrics: Factory.build_list(@num_metrics, :metric)
    })
  end
end

Heart.Seeds.seed()
