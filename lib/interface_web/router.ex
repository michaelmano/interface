defmodule InterfaceWeb.Router do
  use InterfaceWeb, :router
  alias InterfaceWeb.{Auth,Schemas,AuthController}

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug :fetch_session
    plug :fetch_flash
    plug Guardian.Plug.Pipeline, module: Interface.Auth.Token,
      error_handler: Auth.ErrorHandler
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug InterfaceWeb.Plugs.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through [:api, :auth]
    forward "/", Absinthe.Plug,
      schema: Schemas.General
  end

  scope "/graphiql" do
    forward "/", Absinthe.Plug.GraphiQL,
    schema: Schemas.General
  end

  scope "/oauth2" do
    pipe_through :api
    post "/login", AuthController, :store
    post "/logout", AuthController, :destroy
  end
end
