defmodule InterfaceWeb.Router do
  use InterfaceWeb, :router

  pipeline :api do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Interface.InterfaceWeb.Plug.Context
  end

  pipeline :graphql do
    plug :accepts, ["json"]
  end

  scope "/api", do: pipe_through :api
  scope "/graphiql", do: pipe_through :graphql

  forward "/api",
    Absinthe.Plug,
    schema: InterfaceWeb.Schema,
    interface: :simple,
    context: %{pubsub: InterfaceWeb.Endpoint}

  forward "/graphiql",
    Absinthe.Plug.GraphiQL,
    schema: InterfaceWeb.Schema,
    interface: :simple,
    context: %{pubsub: InterfaceWeb.Endpoint}
end