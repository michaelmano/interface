defmodule InterfaceWeb.Plugs.BasicAuth do
  import Plug.Conn
  @headers ["authorization","device-info"]

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :login_details, %{context: context})
      {:error, reason} ->
        conn
        |> put_status(401)
        |> Phoenix.Controller.render(
          InterfaceWeb.ErrorView,
          :"error", %{errors: reason}
        )
        |> halt()
      _ ->
        conn
        |> send_resp(400, "Bad Request")
        |> halt()
    end
  end

  def build_context(conn) do
    @headers
    |> Enum.map(fn (header) -> get_header(conn, header) end)
    |> case do
      [nil,nil] -> {:error, Enum.map(@headers, &"#{&1} header was not set.")}
      [nil,val] -> {:error, "#{List.first(@headers)} header was not set."}
      [val,nil] -> {:error, "#{List.last(@headers)} header was not set."}
      [auth,device] -> {:ok, %{auth: auth, device: device}}
    end
  end

  defp get_header(conn, header) do
    conn
    |> Plug.Conn.get_req_header(header)
    |> List.first
  end
end
