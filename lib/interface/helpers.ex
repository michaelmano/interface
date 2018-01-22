defmodule Interface.Helpers do
  import Plug.Conn
  @doc """
  Simple helper functions that do not require their own module.
  """

  @doc false
  def init(opts), do: opts
  
  def mapify({k,v}, m), do: Map.put(m, k, v)
  
  def empty?([]), do: true
  def empty?(list) when is_list(list), do: false

  def json_resp(conn, code \\ 200, data) do
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(code, Poison.encode!(data, pretty: true))
  end
end
