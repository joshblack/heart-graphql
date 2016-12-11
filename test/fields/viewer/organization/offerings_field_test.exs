defmodule Heart.OrganizationOfferingsFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#organizations:offerings provides a Relay Connection" do
    conn = build_conn()
    num_offerings = 3
    org = insert(:organization, %{
      offerings: build_list(num_offerings, :offering),
    })
    global_id = Node.to_global_id(:organization, org.id, Heart.Schema)

    query = """
    {
      viewer {
        organization(id: "#{global_id}") {
          offerings(first: #{num_offerings}) {
            edges {
              node {
                id
              }
            }
          }
        }
      }
    }
    """

    conn = post conn, "/graphql", %{query: query}
    response = json_response(conn, 200)
    fields = ["data", "viewer", "organization", "offerings", "edges"]

    assert length(get_in(response, fields)) == num_offerings
  end
end
