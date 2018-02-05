defmodule InterfaceWeb.RegisterController do
  import Plug.Conn
  use InterfaceWeb, :controller

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
end
