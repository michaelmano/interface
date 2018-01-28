defmodule InterfaceWeb.UserView do
  use InterfaceWeb, :view
  alias InterfaceWeb.UserView

  def render("user.json", %{user: user}) do
    %{id: user.id, name: user.name, slug: user.slug, email: user.email}
  end
end
