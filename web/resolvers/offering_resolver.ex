defmodule Heart.Resolver.Offering do
  @moduledoc """
  Provides the necessary resolvers for various Offering-related fields.
  """

  alias Heart.Repo
  alias Heart.Offering
  alias Absinthe.Relay.Connection

  # TODO: Remove `inspect` calls to changeset when Absinthe v1.2.2 lands
  def all(pagination_args, _) do
    case Repo.all(Offering) do
      nil -> {:error, "Something went wrong"}
      offerings ->
        # Note: the client _has_ to include connection arguments otherwise
        # this throws
        connection = Connection.from_list(
          offerings,
          pagination_args
        )

        {:ok, connection}
    end
  end

  def create(args, _info) do
    changeset = Offering.changeset(%Offering{}, args)

    case Repo.insert(changeset) do
      {:ok, offering} -> {:ok, %{offering: offering}}
      {:error, changeset} -> {:error, inspect(changeset)}
    end
  end

  def find(%{id: id}, _info) do
    case Repo.get(Offering, id) do
      nil -> not_found(id)
      offering -> {:ok, offering}
    end
  end

  def update(%{id: id, offering: offering_params}, _info) do
    case Repo.get(Offering, id) do
      {:ok, offering} ->
        changeset = Offering.changeset(offering, offering_params)

        case Repo.update(changeset) do
          {:ok, offering} -> {:ok, offering}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
      nil -> not_found(id)
    end
  end

  def delete(%{id: id}, _info) do
    case Repo.get(Offering, id) do
      {:ok, offering} ->
        case Repo.delete(offering) do
          {:ok, offering} -> {:ok, offering}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
      nil -> not_found(id)
    end
  end

  defp not_found(id) do
    {:error, "No offering found for id: #{id}"}
  end
end
