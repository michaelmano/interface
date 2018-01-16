defmodule InterfaceWeb.Auth.CurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case Guardian.Plug.current_resource(conn) do
      nil -> conn
      user -> put_private(conn, :user, %{context: %{current_user: user}})
    end
  end
end