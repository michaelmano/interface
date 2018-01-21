defmodule InterfaceWeb.Plugs.BasicAuth do
  import Plug.Conn

  def init(opts), do: opts
  def call(conn, _) do
    ["authorization", "device_info"]
    |> Enum.map(fn header -> validate_header(conn, header) end)
    |> Enum.map(fn response -> case response do
        {:error, error} -> conn |> send_resp(400, error) |> halt()
        _ -> nil
      end
    end)
    conn
  end

  defp validate_header(conn, header) do
    conn
    |> Plug.Conn.get_req_header(header)
    |> List.first
    |> case do
      nil -> {:error, "The header #{header} was not set."}
      value -> {:ok, value}
    end
  end
end
