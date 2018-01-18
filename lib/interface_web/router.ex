defmodule InterfaceWeb.Router do
  use InterfaceWeb, :router
  alias InterfaceWeb.{Auth,Schemas}

  pipeline :session do
    plug :fetch_session
    plug :fetch_flash
    plug Guardian.Plug.Pipeline, module: Interface.Auth.Token,
      error_handler: Auth.ErrorHandler
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug InterfaceWeb.Context
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through [:api, :session]
    forward "/", Absinthe.Plug,
      schema: Schemas.General
  end

  scope "/graphiql" do
    pipe_through :api
    forward "/", Absinthe.Plug.GraphiQL,
    schema: Schemas.General
  end
end
