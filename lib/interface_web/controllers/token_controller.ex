defmodule InterfaceWeb.TokenController do
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
  
  def destroy(conn, _params) do
    conn
  end

  defp get_header(conn, header) do
    conn
    |> Plug.Conn.get_req_header(header)
    |> List.first
  end
end
