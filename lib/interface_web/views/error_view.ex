defmodule InterfaceWeb.ErrorView do
  use InterfaceWeb, :view
  alias Plug.Conn.Status

  def render("error.json", %{message: message}), do: %{message: message}
end
