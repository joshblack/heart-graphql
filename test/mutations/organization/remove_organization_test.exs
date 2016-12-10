defmodule Heart.RemoveOrganizationTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#removeOrganization updates an organization" do
    conn = build_conn()
    org = insert(:organization)
    global_id = Node.to_global_id(:organization, org.id, Heart.Schema)

    query = """
    mutation M($input: RemoveOrganizationInput!) {
      removeOrganization(input: $input) {
        organization {
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
        "removeOrganization" => %{
          "organization" => %{
            "id" => global_id,
          },
        },
      },
    }
  end
end
