defmodule Heart.Router do
  use Heart.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  forward "/graphql", Absinthe.Plug,
    schema: Heart.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: Heart.Schema
end
