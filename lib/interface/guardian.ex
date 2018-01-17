defmodule Interface.Guardian do
  use Guardian, otp_app: :interface
  alias Interface.Accounts.User
  alias Interface.Repo

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
end
