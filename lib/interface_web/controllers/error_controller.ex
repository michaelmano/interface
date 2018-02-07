defmodule InterfaceWeb.ErrorController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use InterfaceWeb, :controller
  alias Plug.Conn.Status
  alias InterfaceWeb.ErrorView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(InterfaceWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, status, errors}) do
    conn
    |> put_status(status)
    |> render(ErrorView, :"error", %{errors: errors})
  end

  def call(conn, {:error, errors}) do
    conn
    |> put_status(500)
    |> render(ErrorView, :"error", %{errors: errors})
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> render(ErrorView, :"error", %{errors: "Shit son."})
  end

  def auth_error(conn,  {type, _reason}, _opts) do
    conn
    |> put_status(401)
    |> render(
        ErrorView,
        :"error",
        %{errors: %{
            error: to_string(type),
            message: "Your token was invalid, Are you sure it was an access token?"
      }})
  end
end
