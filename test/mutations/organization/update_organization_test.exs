defmodule Heart.UpdateOrganizationTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#updateOrganization updates an organization" do
    conn = build_conn()
    org = insert(:organization)
    global_id = Node.to_global_id(:organization, org.id, Heart.Schema)

    query = """
    mutation M($input: UpdateOrganizationInput!) {
      updateOrganization(input: $input) {
        organization {
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
        name: "Updated Organization",
        description: "Updated Organization description.",
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "updateOrganization" => %{
          "organization" => %{
            "name" => variables.input.name,
            "description" => variables.input.description,
          },
        },
      },
    }
  end
end
