defmodule Heart.GoalsSignalsFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#goal:signals provides a Relay Connection" do
    conn = build_conn()
    num_signals = 3
    goal = insert(:goal, %{
      signals: build_list(num_signals, :signal),
      offering: build(:offering, %{
        organization: build(:organization),
      }),
    })
    global_id = Node.to_global_id(:goal, goal.id, Heart.Schema)

    query = """
    {
      viewer {
        goal(id: "#{global_id}") {
          signals(first: #{num_signals}) {
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
    fields = ["data", "viewer", "goal", "signals", "edges"]

    assert length(get_in(response, fields)) == num_signals
  end
end
