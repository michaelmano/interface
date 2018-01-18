defmodule InterfaceWeb.AuthController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Helpers
  
  @doc false
  def init(opts), do: opts

  def store(conn, _params) do
    headers = conn.req_headers
    |> List.foldl(Map.new(), &Helpers.mapify/2)
	  |> Poison.encode!
    body = Poison.encode!(%{
      "IP" => to_string(:inet_parse.ntoa(conn.remote_ip)),
      "headers" => headers
    })
    
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
