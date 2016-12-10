defmodule Heart.Resolver.Organization do
  @moduledoc """
  Provides the necessary resolvers for various organization-related fields.
  """

  alias Heart.Repo
  alias Heart.Organization

  alias Absinthe.Relay.Connection

  def all(pagination_args, _) do
    case Repo.all(Organization) do
      nil ->
        {:error, "Something went wrong"}
      organizations ->
        # Note: the client _has_ to include connection arguments otherwise
        # this throws
        connection = Connection.from_list(
          organizations,
          pagination_args
        )

        {:ok, connection}
    end
  end

  def find(%{id: id}, _info) do
    case Repo.get(Organization, id) do
      nil -> {:error, "Organization id #{id} not found"}
      org -> {:ok, org}
    end
  end

  def create(args, _info) do
    changeset = Organization.changeset(%Organization{}, args)

    case Repo.insert(changeset) do
      {:ok, organization} -> {:ok, %{organization: organization}}
      {:error, changeset} -> {:error, inspect(changeset)}
    end
  end

  def update(args, _info) do
    case Repo.get(Organization, args.id) do
      nil ->
        not_found(args.id)
      org ->
        changeset = Organization.changeset(org, args)

        case Repo.update(changeset) do
          {:ok, org} -> {:ok, %{organization: org}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  def delete(args, _info) do
    case Repo.get(Organization, args.id) do
      nil ->
        not_found(args.id)
      org ->
        case Repo.delete(org) do
          {:ok, org} -> {:ok, %{organization: org}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  defp not_found(id) do
    {:error, "No organization found for id: #{id}"}
  end
end
