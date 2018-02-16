defmodule InterfaceWeb.TokenView do
  use InterfaceWeb, :view
  
  def render("token.json", %{token: token}) do
    %{
      token: token.token,
      exp: token.claims["exp"]
        |> DateTime.from_unix()
        |> case do
          {:ok, time} -> DateTime.diff(time, DateTime.utc_now())
          error -> error
        end
    }
  end

  def render("show.json", %{refresh: refresh, access: access}) do
    %{tokens: %{
      refresh: render_one(refresh, TokenView, "token.json"),
      access: render_one(access, TokenView, "token.json"),
    }}
  end
end
