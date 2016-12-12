defmodule Heart.CreateGoalTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#createGoal creates a goal" do
    conn = build_conn()
    offering = insert(:offering, %{
      organization: build(:organization),
    })
    global_id = Node.to_global_id(:offering, offering.id, Heart.Schema)

    query = """
    mutation M($input: CreateGoalInput!) {
      createGoal(input: $input) {
        goal {
          title
          description
          offering {
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
        offeringId: global_id,
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "createGoal" => %{
          "goal" => %{
            "title" => variables.input.title,
            "description" => variables.input.description,
            "offering" => %{
              "id" => global_id,
            },
          },
        },
      },
    }
  end
end
