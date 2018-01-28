defmodule InterfaceWeb.TokenView do
  use InterfaceWeb, :view
  alias InterfaceWeb.TokenView

  def render("index.json", %{tokens: tokens}) do
    %{data: render_many(tokens, TokenView, "token.json")}
  end

  def render("show.json", %{token: token}) do
    %{data: render_one(token, TokenView, "token.json")}
  end

  def render("token.json", %{token: token}) do
    %{type: token.claims["typ"], exp: token.claims["exp"], token: token.token}
  end
end
