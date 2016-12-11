defmodule Heart.OrganizationsFieldTest do
  use Heart.ConnCase

  test "#organizations provides a Relay Connection" do
    conn = build_conn()
    org = insert(:organization)

    query = """
    {
      viewer {
        organizations(first: 5) {
          edges {
            node {
              name
              description
            }
          }
        }
      }
    }
    """

    conn = post conn, "/graphql", %{query: query}

    assert json_response(conn, 200) == %{
      "data" => %{
        "viewer" => %{
          "organizations" => %{
            "edges" => [
              %{
                "node" => %{
                  "name" => org.name,
                  "description" => org.description,
                },
              },
            ],
          },
        },
      },
    }
  end
end
