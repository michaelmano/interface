defmodule InterfaceWeb.LoginView do
  use InterfaceWeb, :view
  def render("show.json", %{user: user, tokens: tokens}) do
    %{data: %{
      user: user,
      tokens: Enum.map(tokens, &format_token(&1))
    }}
  end

  defp format_token(token) do
    with {:ok, value} <- DateTime.from_unix(token.claims["exp"]) do
      %{
        type: token.claims["typ"],
        exp: DateTime.diff(value, DateTime.utc_now()),
        token: token.token
      }
    end
  end
end
