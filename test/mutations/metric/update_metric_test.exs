defmodule Heart.UpdateMetricTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#updateMetric updates a metric" do
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
    mutation M($input: UpdateMetricInput!) {
      updateMetric(input: $input) {
        metric {
          id
          name
          description
          target
        }
      }
    }
    """

    variables = %{
      input: %{
        clientMutationId: "a",
        id: global_id,
        name: "Updated Metric name",
        description: "Updated Metric description.",
        target: 30.0,
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "updateMetric" => %{
          "metric" => %{
            "id" => global_id,
            "name" => variables.input.name,
            "description" => variables.input.description,
            "target" => variables.input.target,
          },
        },
      },
    }
  end
end
