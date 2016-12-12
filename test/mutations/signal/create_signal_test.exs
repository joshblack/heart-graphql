defmodule Heart.CreateSignalTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#createSignal creates a signal" do
    conn = build_conn()
    goal = insert(:goal, %{
      offering: build(:offering, %{
        organization: build(:organization),
      }),
    })
    global_id = Node.to_global_id(:goal, goal.id, Heart.Schema)

    query = """
    mutation M($input: CreateSignalInput!) {
      createSignal(input: $input) {
        signal {
          title
          description
          goal {
            id
          }
        }
      }
    }
    """

    variables = %{
      input: %{
        clientMutationId: "a",
        title: Faker.Lorem.sentence(),
        description: Faker.Lorem.paragraph(),
        goalId: global_id,
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "createSignal" => %{
          "signal" => %{
            "title" => variables.input.title,
            "description" => variables.input.description,
            "goal" => %{
              "id" => global_id,
            },
          },
        },
      },
    }
  end
end
