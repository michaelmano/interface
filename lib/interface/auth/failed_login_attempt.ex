defmodule Interface.Auth.FailedLoginAttempt do
  use Ecto.Schema
  import Ecto.Changeset
  alias Interface.Auth.FailedLoginAttempt


  schema "failed_login_attempts" do
    field :attempts, :integer
    field :ip, :string
    field :timeout, :utc_datetime, default: DateTime.utc_now

    timestamps()
  end

  @doc false
  def changeset(%FailedLoginAttempt{} = failed_login_attempts, attrs) do
    failed_login_attempts
    |> cast(attrs, [:ip, :attempts])
    |> validate_required([:ip, :attempts])
  end
end
