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

  # TODO: Create Library that will throttle login attempts and add captcha.
  def store(conn, _params) do
    device_info = Format.format_device_info(conn)
    [username|[password|_]] = Format.format_header(conn, "authorization") |> Format.decode_basic
    case Accounts.authenticate(username, password) do
      {:ok, user} -> Format.json_resp(conn, 200, Token.new_device(user, device_info))
      {:error, error} -> Format.json_resp(conn, 400, %{error: error}) |> halt()
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
