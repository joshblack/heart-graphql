defmodule Heart.Resolver.Goal do
  @moduledoc """
  Provides the necessary resolvers for various Goal-related fields.
  """

  use Heart.Web, :resolver

  alias Heart.Goal
  alias Absinthe.Relay.Connection

  def create(args, _info) do
    changeset = Goal.changeset(%Goal{}, args)

    case Repo.insert(changeset) do
      {:ok, goal} -> {:ok, %{goal: goal}}
      {:error, changeset} -> {:error, inspect(changeset)}
    end
  end

  def find(%{id: id}, _info) do
    case Repo.get(Goal, id) do
      nil -> not_found(id)
      goal -> {:ok, goal}
    end
  end

  def find(_args, _info) do
    {:error, "No arguments supplied for `id` or `slug`."}
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
      |> Connection.from_query(&Repo.all/1, pagination_args)

    {:ok, connection}
  end

  defp not_found(id) do
    {:error, "No goal found for id: #{id}"}
  end
end
