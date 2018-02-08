defmodule InterfaceWeb.ErrorController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use InterfaceWeb, :controller
  alias InterfaceWeb.ErrorView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(InterfaceWeb.ChangesetView, "error.json", changeset: changeset)
  end
  def call(conn, {:error, status, errors}), do: render_errors(conn, errors, status)
  def call(conn, {:error, errors}), do: render_errors(conn, errors)
  def call(conn, _), do: render_errors(conn, "Shit son.", 500)
  
  def auth_error(conn, {_type, reason}, _opts) do
    render_errors(conn, (reason == "typ") && "token_type" || "invalid_token", 401)
  end
  
  def render_errors(conn, errors, status \\ 400) do
    conn
    |> put_status(status)
    |> render(ErrorView, :"error", %{errors: errors})
  end
end
