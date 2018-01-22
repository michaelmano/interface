defmodule InterfaceWeb.AuthController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Accounts
  alias Interface.Helpers
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
    device_info = Helpers.format_device_info(conn)
    [username|[password|_]] = Helpers.format_basic_auth(conn)
    response = case Accounts.authenticate(username, password) do
      {:ok, user} -> 
        Token.new_device(user, device_info)
      {:error, error} -> 
        Helpers.json_resp(conn, 400, %{errors: error})
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
