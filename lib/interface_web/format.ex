defmodule InterfaceWeb.Format do
  import Plug.Conn
  @doc """
  Simple helper functions that do not require their own module.
  """

  def init(opts), do: opts
  
  def mapify({k,v}, m), do: Map.put(m, k, v)
  
  def empty?([]), do: true
  def empty?(list) when is_list(list), do: false

  def json_resp(conn, code \\ 200, data) do
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(code, Poison.encode!(data, pretty: true))
  end

  def format_device_info(conn) do
    conn
    |> get_header("device-info")
  end

  def format_header(conn, header, prefix \\ "Basic ") do
    conn
    |> get_header(header)
    |> String.replace_prefix(prefix, "")
  end

  def decode_basic(header) do
    header
    |> Base.decode64!
    |> String.split(":")
  end

  def get_header(conn, header) do
    conn
    |> get_req_header(header)
    |> List.first
  end
end
