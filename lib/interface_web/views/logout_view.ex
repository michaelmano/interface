defmodule InterfaceWeb.LogoutView do
  use InterfaceWeb, :view

  def render("show.json", %{message: message}) do
    %{data: %{message: message}}
  end
end
