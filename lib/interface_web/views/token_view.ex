defmodule InterfaceWeb.TokenView do
  use InterfaceWeb, :view

  def render("show.json", %{tokens: tokens}) do
    %{data: %{tokens: tokens}}
  end
end
