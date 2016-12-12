defmodule Heart.RemoveMetricTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#removeMetric removes a metric" do
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
    global_id = Node.to_global_id(:metric, metric.id, Heart.Schema)

    query = """
    mutation M($input: RemoveMetricInput!) {
      removeMetric(input: $input) {
        metric {
          id
        }
      }
    }
    """

    variables = %{
      input: %{
        clientMutationId: "a",
        id: global_id,
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "removeMetric" => %{
          "metric" => %{
            "id" => global_id,
          },
        },
      },
    }
  end
end
