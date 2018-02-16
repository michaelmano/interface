defmodule InterfaceWeb.Router do
  use InterfaceWeb, :router
  alias InterfaceWeb.{Schemas}

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

  pipeline :refresh_auth do
    plug Guardian.Plug.Pipeline, module: Interface.Auth,
      error_handler: InterfaceWeb.ErrorController
    plug Guardian.Plug.VerifyHeader,
      realm: "Bearer",
      claims: %{typ: "refresh"}
  end

  pipeline :access_auth do
    plug :fetch_session
    plug :fetch_flash
    plug Guardian.Plug.Pipeline, module: Interface.Auth,
      error_handler: InterfaceWeb.ErrorController
    plug Guardian.Plug.VerifyHeader, 
      realm: "Bearer",
      claims: %{typ: "access"}
    plug Guardian.Plug.LoadResource, allow_blank: false
    plug InterfaceWeb.Plugs.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through [:api, :access_auth]
    forward "/", Absinthe.Plug,
      schema: Schemas.Authenticated
  end

  scope "/auth" do
    pipe_through :api
    post "/logout", InterfaceWeb.LogoutController, :destroy
    post "/register", InterfaceWeb.RegisterController, :create
  end

  scope "/auth" do
    pipe_through [:api, :basic_auth]
    post "/login", InterfaceWeb.LoginController, :store
  end

  scope "/auth" do
    pipe_through [:api, :basic_auth, :refresh_auth]
    post "/refresh", InterfaceWeb.TokenController, :store
  end

  # Remove from production.
  scope "/graphiql" do
    pipe_through :api
    forward "/", Absinthe.Plug.GraphiQL,
    schema: Schemas.Guest
  end
end
