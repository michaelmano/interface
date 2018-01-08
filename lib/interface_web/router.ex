defmodule InterfaceWeb.Router do
  use InterfaceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug.GraphiQL,
      schema: InterfaceWeb.Schema,
      interface: :simple,
      context: %{pubsub: InterfaceWeb.Endpoint}
  end

end