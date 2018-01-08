defmodule Interface.Avatars.Character do
  use Ecto.Schema
  import Ecto.Changeset
  alias Interface.Avatars.Class
  alias Interface.Avatars.Character
  alias Interface.Accounts.User


  schema "characters" do
    field :bio, :string
    field :name, :string
    belongs_to :user, User
    belongs_to :class, Class
    timestamps()
  end

  @doc false
  def changeset(%Character{} = character, attrs) do
    character
    |> cast(attrs, [:name, :bio])
    |> validate_required([:name, :bio])
  end
end
