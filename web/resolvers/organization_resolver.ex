defmodule Heart.Resolver.Organization do
  alias Heart.Repo
  alias Heart.Organization

  alias Absinthe.Relay.Connection

  def all(pagination_args, _) do
    case Repo.all(Organization) do
      organizations ->
        # Note: the client _has_ to include connection arguments otherwise
        # this throws
        connection = Connection.from_list(
          organizations,
          pagination_args
        )

        {:ok, connection}
      nil -> {:error, "Something went wrong"}
    end
  end

  def find(%{id: id}, _info) do
    case Repo.get(Organization, id) do
      nil -> {:error, "Organization id #{id} not found"}
      org -> {:ok, org}
    end
  end
end
