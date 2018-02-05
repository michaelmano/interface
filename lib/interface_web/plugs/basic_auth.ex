defmodule InterfaceWeb.Plugs.BasicAuth do
  import Plug.Conn
  alias InterfaceWeb.Format

  def init(opts), do: opts

  def call(conn, _) do
    Enum.map(["authorization", "device-info"], fn header -> 
      case validate_header(conn, header) do
        {:error, value} -> value
        _ -> nil
      end
    end)
    |> Enum.reject(&is_nil/1)
    |> case do
      [] -> conn
      errors -> 
        conn
        |> put_status(401)
        |> Phoenix.Controller.render(
          InterfaceWeb.ErrorView,
          :"error", %{errors: errors}
        )
        |> halt()
    end
  end

  defp validate_header(conn, header) do
    conn
    |> Plug.Conn.get_req_header(header)
    |> List.first
    |> case do
      nil -> {:error, %{message: "The header #{header} was not set."}}
      value -> nil
    end
  end
end
