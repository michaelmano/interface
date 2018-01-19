defmodule InterfaceWeb.AuthController do
  import Plug.Conn
  use InterfaceWeb, :controller
  
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
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "test")
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
