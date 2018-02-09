defmodule Interface.Auth do
  use Guardian, otp_app: :interface
  alias Comeonin.Bcrypt
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

  def login(%{auth: auth, device: device}) do
    auth
    |> String.replace_prefix("Basic ", "")
    |> decode_auth_header()
    |> case do
      {:ok, details} -> authenticate_user(details)
      error -> error
    end
    |> case do
      {:ok, user} -> add_new_device(user, device)
      error -> error
    end
  end

  def authenticate_user([email | [password|_]]),
    do: authenticate_user(email, password)
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

  def get_current_user(conn) do
    conn
  end

  def decode_auth_header(auth) do
    case Base.decode64(auth) do
      {:ok, val} -> {:ok, String.split(val, ":")}
      _ -> {:error, "String is not valid Base64"}
    end
  end
  
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

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
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

  def add_new_device(user, device_info) do
    claims = %{user_id: user.id, device_info: device_info}
    with {:ok, rf_tk, rf_cl} <- encode_and_sign(user, claims, token_type: "refresh"),
        {:ok, ac_tk, ac_cl} <- encode_and_sign(user, claims, token_type: "access") do
          {:ok, %{
            user: user,
            tokens: [
              %{token: rf_tk, claims: rf_cl},
              %{token: ac_tk, claims: ac_cl},
            ]
          }}
      end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end

  def refresh_tokens(%{auth: auth, device: device}) do
    auth
    |> String.replace_prefix("Bearer ", "")
    |> exchange("refresh", "access")
    |> case do
      {:ok, {rf_tk, rf_cl}, {ac_tk, ac_cl}} -> 
        case device == rf_cl["device_info"] do
          true -> with {:ok, _, {nw_rf_tk, nw_rf_cl}} <- refresh(rf_tk) do
              {:ok, %{tokens: [
                %{token: rf_tk, claims: rf_cl},
                %{token: ac_tk, claims: ac_cl},
              ]}}
            end
          false -> {:error, 401, "invalid_token"} # Wrong device info, most liekly the token was stolen.
        end
      error -> error
    end
  end
end
