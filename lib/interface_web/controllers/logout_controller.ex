defmodule InterfaceWeb.LogoutController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Auth;

  action_fallback InterfaceWeb.ErrorController

  @doc false
  def init(opts), do: opts
  
  def index(conn, _) do
    conn
  end
  
  def create(conn, _params) do
    conn
  end

  def store(conn, _params) do
    conn
  end
  
  def show(conn, _params) do
    conn
  end
  
  def edit(conn, _params) do
    conn
  end
  
  def update(conn, _params) do
    conn
  end
  
  def destroy(conn, tokens) do
    with {:ok, _} <- Auth.revoke(tokens["refresh"]),
      _ <- Auth.revoke(tokens["access"]) do
        render(conn, "show.json", %{message: "You have sucsessfully been logged out."})
    end
  end
end
