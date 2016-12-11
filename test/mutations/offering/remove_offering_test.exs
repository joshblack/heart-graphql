defmodule Heart.RemoveOfferingTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#removeOffering removes an offering" do
    conn = build_conn()
    offering = insert(:offering_organization)
    global_id = Node.to_global_id(:offering, offering.id, Heart.Schema)

    query = """
    mutation M($input: RemoveOfferingInput!) {
      removeOffering(input: $input) {
        offering {
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
        "removeOffering" => %{
          "offering" => %{
            "id" => global_id,
          },
        },
      },
    }
  end
end
