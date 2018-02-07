defmodule InterfaceWeb.LoginController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Accounts
  alias Interface.Auth
  alias InterfaceWeb.Format
  alias InterfaceWeb.Auth.Token

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
    case Auth.login(conn.private[:login_details]) do
      {:ok, details} -> render(conn, "show.json", details)
      error -> error
    end
  end
  
  def show(conn, _params) do
    conn
  end
  
  def edit(conn, _params) do
    conn
  end
  
  def update(conn, _params) do
    conn.private[:guardian_default_token] 
    |> Auth.exchange("refresh", "access")
    |> case do
      {:ok, _, {token, _}} -> Format.json_resp(conn, 200, %{token: token})
    end
  end
  
  def destroy(conn, _params) do
    conn.private[:guardian_default_token]
    |> Auth.revoke()
    |> case do
      {:ok, _} -> Format.json_resp(conn, 200, "You have been logged out.")
    end
  end
end
