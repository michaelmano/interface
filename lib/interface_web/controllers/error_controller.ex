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

  def auth_error(conn, {type, reason}, _opts) do
    error = 
    case is_atom(reason) do
      true -> reason
      _ -> type
    end
    |> to_string
    call(conn, {:error, 401, %{errors: %{error: error}}})
  end
end
