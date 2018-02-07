defmodule InterfaceWeb.TokenView do
  use InterfaceWeb, :view

  def render("token.json", %{token: token}) do
    case DateTime.from_unix(token.claims["exp"]) do
      {:ok, value} ->
        %{
          type: token.claims["typ"],
          exp: DateTime.diff(value, DateTime.utc_now()),
          token: token.token
        }
      error -> error
    end
  end

  def render("refresh.json", %{token: token}) do
    %{data: %{message: "meow"}}
  end
end
