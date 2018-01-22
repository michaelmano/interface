defmodule InterfaceWeb.Auth.Token do
  use Guardian, otp_app: :interface
  alias Interface.Accounts.User
  alias Interface.Repo

  def after_encode_and_sign(resource, claims, token, _options) do
    case Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, _} -> {:ok, token}
      {:error, error} -> {:error, error}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end
  def subject_for_token(), do: {:error, :reason_for_error}

  def resource_from_claims(claims) do
      id = claims["sub"]
      resource = Repo.get(User, id)
      {:ok, resource}
  end
  def resource_from_claims(), do: {:error, :reason_for_error}

  def new_device(user, device_info) do
    claims = %{user_id: user.id, device_info: device_info}
    with {:ok, refresh, _} <- encode_and_sign(user, claims, token_type: "refresh"),
        {:ok, access, _} <- encode_and_sign(user, token_type: "access") do
          %{user: user, tokens: %{ 
            refresh: %{ expires: 367, token: refresh },
            access: %{ expires: 7, token: access } },
          }
      end
  end
end
