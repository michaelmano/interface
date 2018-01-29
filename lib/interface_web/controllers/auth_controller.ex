defmodule InterfaceWeb.AuthController do
  import Plug.Conn
  use InterfaceWeb, :controller
  alias Interface.Accounts
  alias Interface.Auth
  alias InterfaceWeb.Format
  alias InterfaceWeb.Auth.Token

  action_fallback InterfaceWeb.FallbackController

  @doc false
  def init(opts), do: opts
  
  def index(conn, _) do
    conn
  end
  
  def create(conn, _params) do
    conn
  end

  # TODO: Create Library that will throttle login attempts and add captcha.
  def store(conn, _params) do
    [username, password, device_info] = Auth.get_header_info(conn)
    case Accounts.authenticate(username, password) do
      {:ok, user} -> render(conn, "show.json", Token.new_device(user, device_info))
      {:error, error} -> {:error, %{message: error, status: 418}}
    end
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
end
