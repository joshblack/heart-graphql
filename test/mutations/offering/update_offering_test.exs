defmodule Heart.UpdateOfferingTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#updateOffering updates an offering" do
    conn = build_conn()
    offering = insert(:offering_organization)
    global_id = Node.to_global_id(:offering, offering.id, Heart.Schema)

    query = """
    mutation M($input: UpdateOfferingInput!) {
      updateOffering(input: $input) {
        offering {
          name
          description
        }
      }
    }
    """

    variables = %{
      input: %{
        clientMutationId: "a",
        id: global_id,
        name: "Updated Offering Name",
        description: "Updated Offering description.",
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "updateOffering" => %{
          "offering" => %{
            "name" => variables.input.name,
            "description" => variables.input.description,
          },
        },
      },
    }
  end
end
