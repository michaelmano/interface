defmodule InterfaceWeb.AuthController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Accounts
  alias Interface.Auth
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
        response = Token.new_device(user, device_info)
        Format.json_resp(conn, 200, response)
      {:error, error} -> 
        Auth.failed_login_attempt(%{ip: conn.remote_ip})
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
    conn.private[:guardian_default_token] 
    |> Token.exchange("refresh", "access")
    |> case do
      {:ok, _, {token, _}} -> Format.json_resp(conn, 200, %{token: token})
    end
  end
  
  def destroy(conn, _params) do
    conn.private[:guardian_default_token]
    |> Token.revoke()
    |> case do
      {:ok, _} -> Format.json_resp(conn, 200, "You have been logged out.")
    end
  end
end
