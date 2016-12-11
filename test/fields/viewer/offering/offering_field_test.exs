defmodule Heart.OrganizationOfferingFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#offering provides an Offering under an Organization" do
    conn = build_conn()

    offering = insert(:offering_organization)
    offering_id = Node.to_global_id(:offering, offering.id, Heart.Schema)

    query = """
    {
      viewer {
        offering(id: "#{offering_id}") {
          id
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
          "offering" => %{
            "id" => offering_id,
            "name" => offering.name,
            "description" => offering.description,
          },
        },
      },
    }
  end
end
