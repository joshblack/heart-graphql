defmodule Heart.Resolver.Organization do
  @moduledoc """
  Provides the necessary resolvers for various organization-related fields.
  """

  alias Heart.Organization
  alias Absinthe.Relay.Connection

  use Heart.Web, :resolver
  use Heart.Relay.ConnectionHelper, repo: Heart.Repo, module: Organization

  # def all(pagination_args = %{order_by: order, sort: sort}, _info) do
    # query =
      # from o in Organization,
      # order_by: [{^sort, field(o, ^order)}]

    # connection = Connection.from_query(query, &Repo.all/1, pagination_args)

    # {:ok, connection}
  # end

  def all(pagination_args, _info) do
    query =
      from o in Organization,
      order_by: [{:desc, o.inserted_at}]

    %{edges: edges, page_info: page_info} =
      Connection.from_query(query, &Repo.all/1, pagination_args)

    total_count = Repo.one!(from o in Organization, select: count(o.id))

    {:ok, %{edges: edges, page_info: page_info, total_count: total_count}}
  end

  def find(%{id: id}, _info) do
    case Repo.get(Organization, id) do
      nil -> {:error, "Organization id #{id} not found"}
      org -> {:ok, org}
    end
  end

  def find(%{slug: slug}, _info) do
    case Repo.get_by(Organization, slug: slug) do
      nil -> {:error, "Organization slug #{slug} not found"}
      org -> {:ok, org}
    end
  end

  def find(_args, _info) do
    {:error, "No arguments supplied for `id` or `slug`."}
  end

  def create(args, _info) do
    changeset = Organization.changeset(%Organization{}, args)

    case Repo.insert(changeset) do
      {:ok, organization} ->
        {
          :ok,
          %{
            viewer: %{},
            new_organization_edge: get_edge_for(organization)
          }
        }

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

  def offerings(pagination_args, %{source: organization}) do
    connection =
      organization
      |> Ecto.assoc(:offerings)
      |> order_by(desc: :inserted_at)
      |> Connection.from_query(&Repo.all/1, pagination_args)

    {:ok, connection}
  end

  defp not_found(id) do
    {:error, "No organization found for id: #{id}"}
  end
end
