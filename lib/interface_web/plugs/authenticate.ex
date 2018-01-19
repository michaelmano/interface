defmodule InterfaceWeb.Plugs.Authenticate do
  import Plug.Conn

  def init(opts), do: opts
  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})
      {:error, reason} ->
        conn
        |> send_resp(403, reason)
        |> halt()
      _ ->
        conn
        |> send_resp(400, "Bad Request")
        |> halt()
    end
  end

  def build_context(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil -> {:error, "Invalid authorization token"}
      user -> {:ok, user}
    end
  end
end
