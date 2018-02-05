defmodule InterfaceWeb.LoginController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Accounts
  alias Interface.Auth
  alias InterfaceWeb.Format
  alias InterfaceWeb.Auth.Token

  action_fallback InterfaceWeb.ErrorController

  @doc false
  def init(opts), do: opts
  
  def index(conn, _) do
    conn
  end
  
  def create(conn, _params) do
    conn
  end

  def store(conn, _params) do
    conn
    |> Auth.login()
    |> render("show.json")

    # case Auth.login() do
    #   {:ok, values} -> render_authenticated_user(conn, values)
    #   {:error, message} -> {:error, :im_a_teapot, message}
    # end
  end
  
  def show(conn, _params) do
    conn
  end
  
  def edit(conn, _params) do
    conn
  end
  
  def update(conn, _params) do
    conn.private[:guardian_default_token] 
    |> Token.exchange("refresh", "access")
    |> case do
      {:ok, _, {token, _}} -> Format.json_resp(conn, 200, %{token: token})
    end
  end
  
  def destroy(conn, _params) do
    conn.private[:guardian_default_token]
    |> Token.revoke()
    |> case do
      {:ok, _} -> Format.json_resp(conn, 200, "You have been logged out.")
    end
  end

  defp render_authenticated_user(conn, {username, password, device_info}) do
    case Auth.authenticate_user(username, password) do
      {:ok, user} -> render(conn, "show.json", Token.new_device(user, device_info))
      {:error, message} -> {:error, :im_a_teapot, message}
    end
  end
end
