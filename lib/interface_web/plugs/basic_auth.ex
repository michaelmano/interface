defmodule InterfaceWeb.Plugs.BasicAuth do
  import Plug.Conn
  alias Interface.Helpers

  def init(opts), do: opts
  def call(conn, _) do
    ["authorization", "device-info"]
    |> Enum.map(fn header -> validate_header(conn, header) end)
    |> Enum.filter(&!is_nil(&1))
    |> build_response(conn)
  end

  defp validate_header(conn, header) do
    conn
    |> Plug.Conn.get_req_header(header)
    |> List.first
    |> case do
      nil -> "The header #{header} was not set."
      _ -> nil
    end
  end

  defp build_response(errors, conn) do
    case Enum.any?(errors) do
      true -> Helpers.json_resp(conn, 400, %{errors: errors}) |> halt()
      false -> conn
    end
  end
end
