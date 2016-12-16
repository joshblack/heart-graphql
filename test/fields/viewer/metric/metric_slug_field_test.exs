defmodule Heart.MetricSlugFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#metric provides a Metric by a slug" do
    conn = build_conn()
    metric = insert(:metric, %{
      signal: build(:signal, %{
        goal: build(:goal, %{
          offering: build(:offering, %{
            organization: build(:organization),
          }),
        }),
      }),
    })
    metric_id = Node.to_global_id(:metric, metric.id, Heart.Schema)

    query = """
    {
      viewer {
        metric(metricSlug: "#{metric.slug}", signalSlug: "#{metric.signal.slug}") {
          id
          name
          description
          slug
        }
      }
    }
    """

    conn = post conn, "/graphql", %{query: query}

    assert json_response(conn, 200) == %{
      "data" => %{
        "viewer" => %{
          "metric" => %{
            "id" => metric_id,
            "name" => metric.name,
            "description" => metric.description,
            "slug" => metric.slug,
          },
        },
      },
    }
  end
end
