defmodule InterfaceWeb.LoginView do
  use InterfaceWeb, :view
  
  def render("show.json", %{user: user, tokens: tokens}) do
    %{data: %{user: user, tokens: tokens}}
  end
end
