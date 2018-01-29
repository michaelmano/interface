defmodule InterfaceWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use InterfaceWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(InterfaceWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(InterfaceWeb.ErrorView, :"404")
  end

  def call(conn, {:error, %{status: status}}) do
    conn
    |> put_status(status)
    |> render(InterfaceWeb.ErrorView, :"#{status}")
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> render(InterfaceWeb.ErrorView, :"500")
  end
end
