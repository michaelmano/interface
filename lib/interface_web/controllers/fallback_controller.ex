defmodule InterfaceWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use InterfaceWeb, :controller
  alias Plug.Conn.Status

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(InterfaceWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, status, message}) do
    conn
    |> put_status(status)
    |> render(InterfaceWeb.ErrorView, :"error", %{message: message})
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> render(InterfaceWeb.ErrorView, :"error", %{message: "Shit son."})
  end
end
