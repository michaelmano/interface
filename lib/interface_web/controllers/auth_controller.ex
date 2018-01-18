defmodule InterfaceWeb.AuthController do
  import Plug.Conn
  use InterfaceWeb, :controller

  @doc false
  def init(opts), do: opts

  def store(conn, _params) do
    IO.inspect(conn)
    headers = conn.req_headers
    |> List.foldl(Map.new(), &mapify/2)
	  |> Poison.encode!
    body = Poison.encode!(%{
      "IP" => to_string(:inet_parse.ntoa(conn.remote_ip)),
      "headers" => headers
    })
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  def mapify({k,v}, m) do
    Map.put(m, k, v)
  end
end
