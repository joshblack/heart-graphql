defmodule Heart.UpdateSignalTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#updateSignal updates a signal" do
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
    mutation M($input: UpdateSignalInput!) {
      updateSignal(input: $input) {
        signal {
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
        title: "Updated Signal title",
        description: "Updated Signal description.",
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "updateSignal" => %{
          "signal" => %{
            "id" => global_id,
            "title" => variables.input.title,
            "description" => variables.input.description,
          },
        },
      },
    }
  end
end
