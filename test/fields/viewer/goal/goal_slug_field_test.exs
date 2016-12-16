defmodule Heart.GoalSlugFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#goal provides a Goal under an Offering by its slug" do
    conn = build_conn()
    goal = insert(:goal, %{
      offering: build(:offering_organization),
    })
    goal_id = Node.to_global_id(:goal, goal.id, Heart.Schema)

    query = """
    {
      viewer {
        goal(goalSlug: "#{goal.slug}", offeringSlug: "#{goal.offering.slug}") {
          id
          title
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
          "goal" => %{
            "id" => goal_id,
            "title" => goal.title,
            "description" => goal.description,
            "slug" => goal.slug,
          },
        },
      },
    }
  end
end
