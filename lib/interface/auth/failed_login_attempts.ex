defmodule Interface.Auth.FailedLoginAttempts do
  use Ecto.Schema
  import Ecto.Changeset
  alias Interface.Auth.FailedLoginAttempts


  schema "failed_login_attempts" do
    field :attempts, :integer
    field :ip, :string

    timestamps()
  end

  @doc false
  def changeset(%FailedLoginAttempts{} = failed_login_attempts, attrs) do
    failed_login_attempts
    |> cast(attrs, [:ip, :attempts])
    |> validate_required([:ip, :attempts])
  end
end
