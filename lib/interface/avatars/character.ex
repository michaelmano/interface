defmodule Interface.Avatars.Character do
  use Ecto.Schema
  import Ecto.Changeset
  alias Interface.Avatars.Character


  schema "characters" do
    field :bio, :string
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Character{} = character, attrs) do
    character
    |> cast(attrs, [:name, :bio])
    |> validate_required([:name, :bio])
  end
end
