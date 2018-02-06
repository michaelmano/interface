defmodule InterfaceWeb.Plugs.Authenticate do
  import Plug.Conn
  use Phoenix.Controller, only: [render: 3]
  alias InterfaceWeb.ErrorView

  def init(opts), do: opts
  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})
      {:error, reason} ->
        conn
        |> put_status(403)
        |> render(ErrorView,:"error", %{errors: reason})
        |> halt()
      _ ->
        conn
        |> put_status(400)
        |> render(ErrorView,:"error", %{errors: "Bad Request"})
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
