defmodule Heart.CreateOfferingMutationTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#createOffering creates an offering" do
    conn = build_conn()
    org = insert(:organization)
    global_id = Node.to_global_id(:organization, org.id, Heart.Schema)

    query = """
    mutation M($input: CreateOfferingInput!) {
      createOffering(input: $input) {
        offering {
          name
          description
          organization {
            id
          }
        }
      }
    }
    """

    variables = %{
      input: %{
        clientMutationId: "a",
        name: "New Offering",
        description: "Offering description.",
        organizationId: global_id,
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "createOffering" => %{
          "offering" => %{
            "name" => "New Offering",
            "description" => "Offering description.",
            "organization" => %{
              "id" => global_id,
            },
          },
        },
      },
    }
  end
end
