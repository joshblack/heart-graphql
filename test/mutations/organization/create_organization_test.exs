defmodule Heart.CreateOrganizationTest do
  use Heart.ConnCase

  test "#createOrganization creates a new organization" do
    conn = build_conn()

    query = """
    mutation M($input: CreateOrganizationInput!) {
      createOrganization(input: $input) {
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
        name: "New Organization",
        description: "Organization description.",
      },
    }

    conn = post conn, "/graphql", %{query: query, variables: variables}

    assert json_response(conn, 200) == %{
      "data" => %{
        "createOrganization" => %{
          "organization" => %{
            "name" => variables.input.name,
            "description" => variables.input.description,
          }
        }
      }
    }
  end
end
