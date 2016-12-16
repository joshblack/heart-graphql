defmodule Heart.Resolver.Metric do
  @moduledoc """
  Provides the necessary resolvers for various Metric-related fields.
  """

  use Heart.Web, :resolver

  alias Heart.Metric

  def find(%{id: id}, _info) do
    case Repo.get(Metric, id) do
      nil -> not_found(id)
      metric -> {:ok, metric}
    end
  end

  def find(%{signal_slug: signal, metric_slug: metric}, _info) do
    query =
      from m in Metric,
      join: s in assoc(m, :signal),
      where: s.slug == ^signal and m.slug == ^metric,
      select: m

    case Repo.one(query) do
      nil -> {:error, "No Metric found for slug: #{metric}"}
      metric -> {:ok, metric}
    end
  end

  def find(_args, _info) do
    {
      :error,
      "No arguments supplied for `id`, or for `metric_slug` and `signal_slug`."
    }
  end

  def create(args, _info) do
    changeset = Metric.changeset(%Metric{}, args)

    case Repo.insert(changeset) do
      {:ok, metric} -> {:ok, %{metric: metric}}
      {:error, changeset} -> {:error, inspect(changeset)}
    end
  end

  def update(args, _info) do
    case Repo.get(Metric, args.id) do
      nil -> not_found(args.id)
      metric ->
        changeset = Metric.changeset(metric, args)

        case Repo.update(changeset) do
          {:ok, metric} -> {:ok, %{metric: metric}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  def delete(%{id: id}, _info) do
    case Repo.get(Metric, id) do
      nil -> not_found(id)
      metric ->
        case Repo.delete(metric) do
          {:ok, metric} -> {:ok, %{metric: metric}}
          {:error, changeset} -> {:error, inspect(changeset)}
        end
    end
  end

  defp not_found(id) do
    {:error, "No metric found for id: #{id}"}
  end
end
