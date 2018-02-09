defmodule InterfaceWeb.LoginView do
  use InterfaceWeb, :view
  alias InterfaceWeb.{UserView, TokenView}

  def render("show.json", %{user: user, tokens: tokens}) do
    %{data: %{
      user: render_one(user, UserView, "user.json"), 
      tokens: render_many(tokens, TokenView, "token.json")
    }}
  end
end
