defmodule InterfaceWeb.TokenController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Auth

  action_fallback InterfaceWeb.ErrorController

  @doc false
  def init(opts), do: opts
  def store(conn, _params) do
    case Auth.refresh_tokens(conn.private[:auth_and_device_headers]) do
      {:ok, tokens} -> render(conn, "show.json", tokens)
      error -> error
    end
  end
end
