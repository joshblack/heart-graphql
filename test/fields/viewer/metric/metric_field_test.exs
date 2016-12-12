defmodule Heart.MetricFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#metric provides a Metric by id" do
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
        metric(id: "#{metric_id}") {
          id
          name
          description
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
          },
        },
      },
    }
  end
end
