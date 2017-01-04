defmodule Heart.Resolver.Metric do
  @moduledoc """
  Provides the necessary resolvers for various Metric-related fields.
  """

  alias Heart.Metric

  use Heart.Web, :resolver
  use Heart.Relay.ConnectionHelper, repo: Heart.Repo, module: Metric

  def find(%{id: id}, _info) do
    case Repo.get(Metric, id) do
      nil -> not_found(id)
      metric -> {:ok, metric}
    end
  end

  def find(%{metric_slug: metric, offering_slug: offering}, _info) do
    query =
      from m in Metric,
      join: s in assoc(m, :signal),
      join: g in assoc(s, :goal),
      join: o in assoc(g, :offering),
      where: m.slug == ^metric and o.slug == ^offering

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
    IO.inspect args

    changeset = Metric.changeset(%Metric{}, args)

    case Repo.insert(changeset) do
      {:ok, metric} ->
        metric = Repo.preload(metric, :signal)

        {
          :ok,
          %{
            signal: metric.signal,
            new_metric_edge: get_edge_for(metric),
          }
        }
      {:error, changeset} ->
        IO.inspect(changeset)
        {:error, inspect(changeset)}
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
