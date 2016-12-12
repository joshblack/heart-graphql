defmodule Heart.UpdateGoalTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#updateGoal updates a goal" do
    conn = build_conn()
    goal = insert(:goal, %{
      offering: build(:offering, %{
        organization: build(:organization),
      }),
    })
    global_id = Node.to_global_id(:goal, goal.id, Heart.Schema)

    query = """
    mutation M($input: UpdateGoalInput!) {
      updateGoal(input: $input) {
        goal {
          id
          title
          description
        }
      }
    }
    """

    variables = %{
      input: %{
        clientMutationId: "a",
        id: global_id,
        title: "Updated Goal title",
        description: "Updated Goal description.",
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "updateGoal" => %{
          "goal" => %{
            "id" => global_id,
            "title" => variables.input.title,
            "description" => variables.input.description,
          },
        },
      },
    }
  end
end
