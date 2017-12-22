defmodule Interface.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Interface.Accounts.User
  alias Interface.Avatars.Character


  schema "users" do
    field :email, :string
    field :name, :string
    has_many :characters, Character, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
