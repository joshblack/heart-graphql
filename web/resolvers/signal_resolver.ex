defmodule Heart.Resolver.Signal do
  @moduledoc """
  Provides the necessary resolvers for various Signal-related fields.
  """

  use Heart.Web, :resolver

  alias Heart.Signal
  alias Absinthe.Relay.Connection

  def find(%{id: id}, _info) do
    case Repo.get(Signal, id) do
      nil -> not_found(id)
      signal -> {:ok, signal}
    end
  end

  def create(args, _info) do
    changeset = Signal.changeset(%Signal{}, args)

    case Repo.insert(changeset) do
      {:ok, signal} -> {:ok, %{signal: signal}}
      {:error, changeset} -> {:error, inspect(changeset)}
    end
  end

  def update(args, _info) do
    case Repo.get(Signal, args.id) do
      nil -> not_found(args.id)
      signal ->
        changeset = Signal.changeset(signal, args)

        case Repo.update(changeset) do
          {:ok, signal} -> {:ok, %{signal: signal}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  def delete(%{id: id}, _info) do
    case Repo.get(Signal, id) do
      nil -> not_found(id)
      signal ->
        case Repo.delete(signal) do
          {:ok, signal} -> {:ok, %{signal: signal}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  def metrics(pagination_args, %{source: signal}) do
    connection =
      signal
      |> Ecto.assoc(:metrics)
      |> Connection.from_query(&Repo.all/1, pagination_args)

    {:ok, connection}
  end

  defp not_found(id) do
    {:error, "No signal found for id: #{id}"}
  end
end
