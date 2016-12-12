defmodule Heart.SignalFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#signal provides a Signal under a Goal by id" do
    conn = build_conn()
    signal = insert(:signal, %{
      goal: build(:goal, %{
        offering: build(:offering, %{
          organization: build(:organization),
        }),
      }),
    })
    signal_id = Node.to_global_id(:signal, signal.id, Heart.Schema)

    query = """
    {
      viewer {
        signal(id: "#{signal_id}") {
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
          "signal" => %{
            "id" => signal_id,
            "title" => signal.title,
            "description" => signal.description,
          },
        },
      },
    }
  end
end
