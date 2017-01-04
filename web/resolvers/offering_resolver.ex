defmodule Heart.Resolver.Offering do
  @moduledoc """
  Provides the necessary resolvers for various Offering-related fields.
  """

  alias Heart.Offering
  alias Absinthe.Relay.Connection

  use Heart.Web, :resolver
  use Heart.Relay.ConnectionHelper, repo: Heart.Repo, module: Offering

  def create(args, _info) do
    changeset = Offering.changeset(%Offering{}, args)

    case Repo.insert(changeset) do
      {:ok, offering} ->
        offering = Repo.preload(offering, :organization)
        payload =
          Map.new()
          |> Map.put(:organization, offering.organization)
          |> Map.put(:new_organization_edge, get_edge_for(offering))

        {:ok, payload}
      {:error, changeset} -> {:error, inspect(changeset)}
    end
  end

  def find(%{id: id}, _info) do
    case Repo.get(Offering, id) do
      nil -> not_found(id)
      offering -> {:ok, offering}
    end
  end

  def find(%{slug: slug}, _info) do
    case Repo.get_by(Offering, slug: slug) do
      nil -> {:error, "Offering slug #{slug} not found"}
      org -> {:ok, org}
    end
  end

  def find(_args, _info) do
    {:error, "No arguments supplied for `id` or `slug`."}
  end

  def update(args, _info) do
    case Repo.get(Offering, args.id) do
      nil -> not_found(args.id)
      offering ->
        changeset = Offering.changeset(offering, args)

        case Repo.update(changeset) do
          {:ok, offering} -> {:ok, %{offering: offering}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  def delete(args, _info) do
    case Repo.get(Offering, args.id) do
      nil -> not_found(args.id)
      offering ->
        case Repo.delete(offering) do
          {:ok, offering} -> {:ok, %{offering: offering}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  def goals(pagination_args, %{source: offering}) do
    connection =
      offering
      |> Ecto.assoc(:goals)
      |> order_by(desc: :inserted_at)
      |> Connection.from_query(&Repo.all/1, pagination_args)

    {:ok, connection}
  end

  defp not_found(id) do
    {:error, "No offering found for id: #{id}"}
  end
end
