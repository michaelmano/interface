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
    token = conn.private[:guardian_default_token]
    type = Map.get(conn.private[:guardian_default_claims], "typ")
    # new_token = Token.exchange(token, "refresh", "access")
    conn |> send_resp(200, "ta da")
  end
  
  def destroy(conn, _params) do
    conn
  end
end
