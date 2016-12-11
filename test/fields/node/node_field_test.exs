defmodule Heart.NodeFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#node provides a Relay Node interface to re-fetch an organization by id" do
    conn = build_conn()
    org = insert(:organization)
    org_id = Node.to_global_id(:organization, org.id, Heart.Schema)

    query = """
    {
      node(id: "#{org_id}") {
        id
        ... on Organization {
          name
          description
        }
      }
    }
    """

    conn = post conn, "/graphql", %{query: query}

    assert json_response(conn, 200) == %{
      "data" => %{
        "node" => %{
          "id" => org_id,
          "name" => org.name,
          "description" => org.description,
        },
      },
    }
  end
end
