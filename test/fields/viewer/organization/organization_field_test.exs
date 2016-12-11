defmodule Heart.OrganizationFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#organization can retrieve a specific resource" do
    conn = build_conn()
    org = insert(:organization)
    global_id = Node.to_global_id(:organization, org.id, Heart.Schema)

    query = """
    {
      viewer {
        organization(id: "#{global_id}") {
          name
          description
        }
      }
    }
    """

    conn = post conn, "/graphql", %{query: query}

    assert json_response(conn, 200) == %{
      "data" => %{
        "viewer" => %{
          "organization" => %{
            "name" => org.name,
            "description" => org.description,
          },
        },
      },
    }
  end
end
