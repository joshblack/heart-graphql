defmodule Heart.CreateMetricTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#createMetric creates a metric" do
    conn = build_conn()
    signal = insert(:signal, %{
      goal: build(:goal, %{
        offering: build(:offering, %{
          organization: build(:organization),
        }),
      }),
    })
    global_id = Node.to_global_id(:signal, signal.id, Heart.Schema)

    query = """
    mutation M($input: CreateMetricInput!) {
      createMetric(input: $input) {
        metric {
          name
          description
          target
          signal {
            id
          }
        }
      }
    }
    """

    variables = %{
      input: %{
        clientMutationId: "a",
        name: "New Metric",
        description: "New Metric description.",
        target: 25.0,
        signalId: global_id,
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "createMetric" => %{
          "metric" => %{
            "name" => variables.input.name,
            "description" => variables.input.description,
            "target" => variables.input.target,
            "signal" => %{
              "id" => global_id,
            },
          },
        },
      },
    }
  end
end
