defmodule Heart.Resolver.Goal do
  @moduledoc """
  Provides the necessary resolvers for various Goal-related fields.
  """

  alias Heart.Goal
  alias Absinthe.Relay.Connection

  use Heart.Web, :resolver
  use Heart.Relay.ConnectionHelper, repo: Heart.Repo, module: Goal

  def create(args, _info) do
    changeset = Goal.changeset(%Goal{}, args)

    case Repo.insert(changeset) do
      {:ok, goal} ->
        goal = Repo.preload(goal, :offering)

        {
          :ok,
          %{
            offering: goal.offering,
            new_goal_edge: get_edge_for(goal),
          }
        }
      {:error, changeset} -> {:error, inspect(changeset)}
    end
  end

  def find(%{id: id}, _info) do
    case Repo.get(Goal, id) do
      nil -> not_found(id)
      goal -> {:ok, goal}
    end
  end

  def find(%{goal_slug: goal, offering_slug: offering}, _info) do
    query =
      from g in Goal,
      join: o in assoc(g, :offering),
      where: g.slug == ^goal and o.slug == ^offering,
      select: g

    case Repo.one(query) do
      nil -> {:error, "No Goal found for slug: #{goal}"}
      goal -> {:ok, goal}
    end
  end

  def find(_args, _info) do
    {
      :error,
      "No arguments supplied for `id`, or for `goal_slug` and `offering_slug`."
    }
  end

  def update(args, _info) do
    case Repo.get(Goal, args.id) do
      nil -> not_found(args.id)
      goal ->
        changeset = Goal.changeset(goal, args)

        case Repo.update(changeset) do
          {:ok, goal} -> {:ok, %{goal: goal}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  def delete(%{id: id}, _info) do
    case Repo.get(Goal, id) do
      nil -> not_found(id)
      goal ->
        case Repo.delete(goal) do
          {:ok, goal} -> {:ok, %{goal: goal}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  def signals(pagination_args, %{source: goal}) do
    connection =
      goal
      |> Ecto.assoc(:signals)
      |> order_by(desc: :inserted_at)
      |> Connection.from_query(&Repo.all/1, pagination_args)

    {:ok, connection}
  end

  defp not_found(id) do
    {:error, "No goal found for id: #{id}"}
  end
end
