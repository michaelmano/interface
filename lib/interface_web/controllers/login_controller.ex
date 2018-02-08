defmodule InterfaceWeb.LoginController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Auth

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
    case Auth.login(conn.private[:auth_and_device_headers]) do
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
    conn
  end
  
  def destroy(conn, _params) do
    conn
  end
end
