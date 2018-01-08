defmodule Interface.Avatars.Class do
  use Ecto.Schema
  import Ecto.Changeset
  alias Interface.Avatars.Class
  alias Interface.Avatars.Character


  schema "classes" do
    field :description, :string
    field :excerpt, :string
    field :name, :string
    has_many :characters, Character
    timestamps()
  end

  @doc false
  def changeset(%Class{} = class, attrs) do
    class
    |> cast(attrs, [:name, :description, :excerpt])
    |> validate_required([:name, :description, :excerpt])
  end
end
