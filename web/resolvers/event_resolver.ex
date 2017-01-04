defmodule Heart.Resolver.Event do
  @moduledoc """
  Provides the necessary resolvers for various Event-related fields.
  """

  alias Heart.Error
  alias Heart.Event
  alias Heart.Offering
  alias Poison.Parser

  use Heart.Web, :resolver

  def create(%{
    type: slug,
    value: value,
    properties: properties,
    offering_id: offering_id,
  }, _info) do
    find_metric_query(offering_id: offering_id, slug: slug)
    |> Repo.one()
    |> case do
      nil ->
        {:error, Error.not_found(type: "Metric", slug: slug)}
      metric ->
        changeset = Event.changeset(%Event{}, %{
          value: value,
          # TODO: What happens if parse!/1 throws?
          properties: Parser.parse!(properties),
          metric_id: metric.id,
        })

        case Repo.insert(changeset) do
          {:ok, event} -> {:ok, event}
          {:error, changeset} -> {:error, Error.format(changeset)}
        end
    end
  end

  def create(%{type: slug, value: value, offering_id: offering_id}, _info) do
    find_metric_query(offering_id: offering_id, slug: slug)
    |> Repo.one()
    |> case do
      nil ->
        {:error, Error.not_found(type: "Metric", slug: slug)}
      metric ->
        changeset = Event.changeset(%Event{}, %{
          value: value,
          metric_id: metric.id,
        })

        case Repo.insert(changeset) do
          {:ok, event} -> {:ok, event}
          {:error, changeset} -> {:error, Error.format(changeset)}
        end
    end
  end

  defp find_metric_query(offering_id: offering_id, slug: slug) do
    from o in Offering,
    join: m in assoc(o, :metrics),
    where: o.id == ^offering_id and
            m.slug == ^slug,
    select: m
  end
end
