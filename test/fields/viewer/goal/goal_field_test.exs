defmodule Heart.GoalFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#goal provides a Goal under an Offering by id" do
    conn = build_conn()
    goal = insert(:goal, %{
      offering: build(:offering_organization),
    })
    goal_id = Node.to_global_id(:goal, goal.id, Heart.Schema)

    query = """
    {
      viewer {
        goal(id: "#{goal_id}") {
          id
          title
          description
        }
      }
    }
    """

    conn = post conn, "/graphql", %{query: query}

    assert json_response(conn, 200) == %{
      "data" => %{
        "viewer" => %{
          "goal" => %{
            "id" => goal_id,
            "title" => goal.title,
            "description" => goal.description,
          },
        },
      },
    }
  end
end
