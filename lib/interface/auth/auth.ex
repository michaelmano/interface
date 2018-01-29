defmodule Interface.Auth do
  alias Comeonin.Bcrypt
  alias InterfaceWeb.Format
  alias Interface.Accounts.User
  alias Interface.Repo
  @moduledoc """
  The Auth context.
  """
  @doc """
  Returns a list of [username, password, device_info]
  ## Examples
      iex> [username, password, device_info] = Auth.get_header_info(conn)
  """
  def get_header_info(conn) do
    device_info = Format.format_device_info(conn)
    case Format.format_header(conn, "authorization") |> Format.decode_basic do
      {:ok, [username|[password|_]]} -> {:ok, {username, password, device_info}}
      error -> error
    end
  end

  def authenticate_user(email, password) do
    User
    |> Repo.get_by(email: email)
    |> validate_and_return_user(password)
  end

  defp validate_and_return_user(nil, _), do: {:error, "Credentials do not match."}
  defp validate_and_return_user(user, password) do
    check_password(user, password)
  end

  def check_password(user, password) do
    case Bcrypt.checkpw(password, user.hashed_password) do
      true  -> {:ok, Map.take(user, [:id, :name, :email, :slug])}
      false -> {:error, "Credentials do not match."}
    end
  end
end
