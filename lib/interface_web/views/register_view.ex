defmodule InterfaceWeb.RegisterView do
  use InterfaceWeb, :view
  alias InterfaceWeb.{UserView, TokenView}

  def render("show.json", %{user: user, tokens: %{refresh: refresh, access: access}}) do
    %{data: %{
      user: render_one(user, UserView, "user.json"), 
      tokens: %{
        refresh: render_one(refresh, TokenView, "token.json"),
        access: render_one(access, TokenView, "token.json"),
      }
    }}
  end
end
