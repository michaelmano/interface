defmodule InterfaceWeb.UserView do
  use InterfaceWeb, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      slug: user.slug,
      avatar: nil,
      name: user.name,
      email: user.email
    }
  end
end
