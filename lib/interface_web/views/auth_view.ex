defmodule InterfaceWeb.AuthView do
  use InterfaceWeb, :view
  alias InterfaceWeb.AuthView
  alias InterfaceWeb.UserView
  alias InterfaceWeb.TokenView

  def render("show.json", %{user: user, tokens: tokens}) do
    %{
      data:
        %{
          user: render_one(user, UserView, "user.json"),
          tokens: render_many(tokens, TokenView, "token.json"),
        }
    }
  end
end
