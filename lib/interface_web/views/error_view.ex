defmodule InterfaceWeb.ErrorView do
  use InterfaceWeb, :view
  alias Plug.Conn.Status

  def render("error.json", %{errors: errors}) do
    %{data: %{errors: errors}}
  end
end
