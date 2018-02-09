defmodule InterfaceWeb.TokenView do
  use InterfaceWeb, :view

  def render("token.json", %{token: token}) do
    %{
      type: token.claims["typ"],
      token: token.token,
      exp: token.claims["exp"]
        |> DateTime.from_unix()
        |> case do
          {:ok, time} -> DateTime.diff(time, DateTime.utc_now())
          error -> error
        end
    }
  end
end
