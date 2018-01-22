defmodule InterfaceWeb.AuthController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Accounts
  alias InterfaceWeb.Format
  alias InterfaceWeb.Auth.Token

  @doc false
  def init(opts), do: opts
  
  def index(conn, _) do
    conn
  end
  
  def create(conn, _params) do
    conn
  end

  def store(conn, _params) do
    device_info = Format.format_device_info(conn)
    [username|[password|_]] = Format.format_header(conn, "authorization") |> Format.decode_basic
    case Accounts.authenticate(username, password) do
      {:ok, user} ->
        response = Token.new_device(conn, user, device_info)
        Format.json_resp(conn, 200, response)
      {:error, error} -> 
        Format.json_resp(conn, 400, %{errors: error}) |> halt()
    end
  end
  
  def show(conn, _params) do
    conn
  end
  
  def edit(conn, _params) do
    conn
  end
  
  def update(conn, _params) do
    {:ok, _old_stuff, {new_token, new_claims}} = 
    conn.private[:guardian_default_token] 
    |> Token.exchange("refresh", "access")
    Format.json_resp(conn, 200, %{token: new_token})
  end
  
  def destroy(conn, _params) do
    conn.private[:guardian_default_token]
    |> Token.revoke()
    |> case do
      {:ok, _} -> Format.json_resp(conn, 200, "You have been logged out.")
    end
  end
end
