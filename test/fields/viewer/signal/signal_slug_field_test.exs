defmodule Heart.SignalSlugFieldTest do
  use Heart.ConnCase

  alias Absinthe.Relay.Node

  test "#signal provides a Signal through its slug" do
    conn = build_conn()
    signal = insert(:signal, %{
      goal: build(:goal, %{
        offering: build(:offering, %{
          organization: build(:organization),
        }),
      }),
    })
    signal_id = Node.to_global_id(:signal, signal.id, Heart.Schema)

    query = """
    {
      viewer {
        signal(signalSlug: "#{signal.slug}", goalSlug: "#{signal.goal.slug}") {
          id
          title
          description
          slug
        }
      }
    }
    """

    conn = post conn, "/graphql", %{query: query}

    assert json_response(conn, 200) == %{
      "data" => %{
        "viewer" => %{
          "signal" => %{
            "id" => signal_id,
            "title" => signal.title,
            "description" => signal.description,
            "slug" => signal.slug,
          },
        },
      },
    }
  end
end
