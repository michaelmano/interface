defmodule InterfaceWeb.Router do
  use InterfaceWeb, :router
  alias InterfaceWeb.{Auth,Schemas}

  pipeline :session do
    plug Guardian.Plug.Pipeline, module: Interface.Guardian,
      error_handler: Auth.ErrorHandler
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    # plug Guardian.Plug.LoadResource (This has been removed as it will only allow users past.)
    plug Auth.CurrentUser
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