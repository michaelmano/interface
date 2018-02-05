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

  pipeline :authenticated do
    plug InterfaceWeb.Plugs.Authenticate
  end

  pipeline :guardian do
    plug :fetch_session
    plug :fetch_flash
    plug Guardian.Plug.Pipeline, module: InterfaceWeb.Auth.Token,
      error_handler: InterfaceWeb.ErrorController
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through [:api, :guardian, :authenticated]
    forward "/", Absinthe.Plug,
      schema: Schemas.Authenticated
  end

  scope "/graphiql" do
    forward "/", Absinthe.Plug.GraphiQL,
    schema: Schemas.Guest
  end

  scope "/auth" do
    pipe_through [:api, :basic_auth, :guardian]
    post "/register", InterfaceWeb.RegisterController, :create
    post "/login", InterfaceWeb.LoginController, :store

    pipe_through :authenticated
    post "/logout", InterfaceWeb.LogoutController, :destroy
    # Create token route for creating, refreshing, destroying.
  end
end
