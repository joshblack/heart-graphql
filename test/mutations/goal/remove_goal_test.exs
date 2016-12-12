defmodule Heart.RemoveGoalTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#removeOffering removes an offering" do
    conn = build_conn()
    goal = insert(:goal, %{
      offering: build(:offering, %{
        organization: build(:organization),
      }),
    })
    global_id = Node.to_global_id(:goal, goal.id, Heart.Schema)

    query = """
    mutation M($input: RemoveGoalInput!) {
      removeGoal(input: $input) {
        goal {
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
        "removeGoal" => %{
          "goal" => %{
            "id" => global_id,
          },
        },
      },
    }
  end
end
