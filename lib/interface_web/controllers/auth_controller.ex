defmodule InterfaceWeb.AuthController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Accounts
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
    device_info = format_device_info(conn)
    [username|[password|_]] = format_basic_auth(conn)
    response = case Accounts.authenticate(username, password) do
      {:ok, user} -> Token.new_device(user, device_info)
      {:error, error} -> error
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
  
  defp format_device_info(conn) do
    conn
    |> get_header("device_info")  
  end

  defp format_basic_auth(conn) do
    conn
    |> get_header("authorization")
    |> String.replace_prefix("Basic ", "")
    |> Base.decode64!
    |> String.split(":")
  end

  defp get_header(conn, header) do
    conn
    |> Plug.Conn.get_req_header(header)
    |> List.first
  end
end
