defmodule InterfaceWeb.Plugs.BasicAuth do
  alias Interface.Accounts
  alias InterfaceWeb.Auth.Token

  def init(opts), do: opts
  def call(conn, _) do
    device_info = validate_header(conn, "device_info")
    validate_header(conn, "authorization")
    |> format_basic_auth()
    |> validate_user(device_info)
    |> IO.inspect()
    conn
  end

  defp validate_header(conn, header) do
    conn
    |> Plug.Conn.get_req_header(header)
    |> List.first
  end

  def format_basic_auth(nil), do: {:error, "No Authorization header set"}
  def format_basic_auth(auth_credentials) do
    auth_credentials
    |> String.replace_prefix("Basic ", "")
    |> Base.decode64!
    |> String.split(":")
  end

  defp validate_user([username|[password|_]], info) do
    with {:ok, user } <- Accounts.authenticate(username, password) do
      claims = %{user_id: user.id, device_info: info}
      with {:ok, refresh, _} <- Token.encode_and_sign(user, claims, token_type: "refresh"),
        {:ok, access, _} <- Token.encode_and_sign(user, token_type: "access") do
          {:ok, %{refresh: refresh, access: access}}
      end
    end
  end
end
