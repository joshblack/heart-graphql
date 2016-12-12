defmodule Heart.RemoveSignalTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#removeSignal removes an signal" do
    conn = build_conn()
    signal = insert(:signal, %{
      goal: build(:goal, %{
        offering: build(:offering, %{
          organization: build(:organization),
        }),
      }), })
    global_id = Node.to_global_id(:signal, signal.id, Heart.Schema)

    query = """
    mutation M($input: RemoveSignalInput!) {
      removeSignal(input: $input) {
        signal {
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
        "removeSignal" => %{
          "signal" => %{
            "id" => global_id,
          },
        },
      },
    }
  end
end
