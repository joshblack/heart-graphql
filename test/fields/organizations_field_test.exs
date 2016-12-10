defmodule Heart.OrganizationsFieldTest do
  use Heart.ConnCase

  test "#organizations provides a Relay Connection" do
    conn = build_conn()
    org = insert(:organization)

    conn = post conn, "/graphql", %{
      query: """
      query viewerQuery {
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
      """,
    }

    assert json_response(conn, 200) == %{
      "data" => %{
        "viewer" => %{
          "organizations" => %{
            "edges" => [
              %{
                "node" => %{
                  "name" => org.name,
                  "description" => org.description
                }
              }
            ]
          }
        }
      }
    }
  end
end
