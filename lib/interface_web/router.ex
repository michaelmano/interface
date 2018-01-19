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

  pipeline :basic_auth do
    plug InterfaceWeb.Plugs.BasicAuth
  end

  pipeline :oauth do
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
    pipe_through [:api, :oauth]
    forward "/", Absinthe.Plug,
      schema: Schemas.General
  end

  scope "/graphiql" do
    forward "/", Absinthe.Plug.GraphiQL,
    schema: Schemas.General
  end

  scope "/auth" do
    pipe_through [:api, :basic_auth]
    post "/register", AuthController, :create
    post "/login", AuthController, :store
  end
end
