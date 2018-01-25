defmodule Interface.Auth do
  alias InterfaceWeb.Format
  @moduledoc """
  The Auth context.
  """
  @doc """
  Returns a list of [username, password, device_info]
  ## Examples
      iex> [username, password, device_info] = Auth.get_header_info(conn)
  """
  def get_header_info(conn) do
    device_info = Format.format_device_info(conn)
    [username|[password|_]] = Format.format_header(conn, "authorization")
    |> Format.decode_basic
    [username, password, device_info]
  end
end
