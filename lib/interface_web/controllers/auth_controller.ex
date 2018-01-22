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
    [username|[password|_]] = Format.format_basic_auth(conn)
    response = case Accounts.authenticate(username, password) do
      {:ok, user} -> 
        result = Token.new_device(user, device_info)
        Format.json_resp(conn, 200, result)
      {:error, error} -> 
        Format.json_resp(conn, 400, %{errors: error})
        |> halt()
    end
    conn
    |> json(response)
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
  
  def destroy(conn, _params) do
    conn
  end
end
