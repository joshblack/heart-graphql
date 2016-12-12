defmodule Heart.SignalsFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#signal:metrics provides a Relay Connection" do
    conn = build_conn()
    num_metrics = 3
    signal = insert(:signal, %{
      metrics: build_list(num_metrics, :metric),
      goal: build(:goal, %{
        offering: build(:offering, %{
          organization: build(:organization),
        }),
      }),
    })
    global_id = Node.to_global_id(:signal, signal.id, Heart.Schema)

    query = """
    {
      viewer {
        signal(id: "#{global_id}") {
          metrics(first: #{num_metrics}) {
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
    fields = ["data", "viewer", "signal", "metrics", "edges"]

    assert length(get_in(response, fields)) == num_metrics
  end
end
