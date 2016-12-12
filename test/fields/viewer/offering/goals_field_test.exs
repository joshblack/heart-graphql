defmodule Heart.OfferingGoalsFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#offering:goals provides a Relay Connection" do
    conn = build_conn()
    num_goals = 3
    offering = insert(:offering_organization, %{
      goals: build_list(num_goals, :goal),
    })
    global_id = Node.to_global_id(:offering, offering.id, Heart.Schema)

    query = """
    {
      viewer {
        offering(id: "#{global_id}") {
          goals(first: #{num_goals}) {
            edges {
              node {
                id
              }
            }
          }
        }
      }
    }
    """

    conn = post conn, "/graphql", %{query: query}
    response = json_response(conn, 200)
    fields = ["data", "viewer", "offering", "goals", "edges"]

    assert length(get_in(response, fields)) == num_goals
  end
end
