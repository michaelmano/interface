defmodule Interface.Accounts.User do
  @moduledoc """
  Represents a user in the application.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt
  alias Interface.Accounts.User

  @public_user_details [:id, :name, :email, :slug]

  schema "users" do
    field :email, :string, unique: true
    field :name, :string
    field :hashed_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :slug, :string, unique: true

    timestamps()
  end
  
  @doc false
  def create_changeset(%User{} = user, attrs) do
    user
    |> cast_user(attrs)
    |> validate_required([
      :name,
      :email,
      :password,
      :password_confirmation,
      :slug
    ])
    |> validate_fields()
  end

  def update_changeset(%User{} = user, attrs) do
    user
    |> cast_user(attrs)
    |> validate_required([
      :name,
      :email,
      :slug
    ])
    |> validate_fields()
  end

  def check_password(user, password) do
    case Bcrypt.checkpw(password, user.hashed_password) do
      true  -> {:valid, Map.take(user, @public_user_details)}
      false -> {:invalid, nil}
    end
  end

  defp cast_user(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :email,
      :hashed_password,
      :password,
      :password_confirmation,
      :slug,
    ])
  end

  defp validate_fields(changeset) do
    changeset
    # |> validate_format(:email, ~r/@bcm\.com\.au/)
    |> validate_length(:name, min: 2)
    |> validate_length(:slug, min: 2)
    |> validate_length(:password, min: 8)
    |> validate_password_confirmation()
    |> unique_constraint(:email)
    |> unique_constraint(:slug)
    |> create_password_hash()
    |> create_slug()
  end

  defp validate_password_confirmation(%{changes: changes} = changeset) do
    changes
    |> Map.take([:password, :password_confirmation])
    |> Map.to_list()
    |> Enum.count()
    |> case do
      2 -> confirm_passwords_match(changeset)
      1 -> add_error(changeset, :password, "must be confirmed")
      0 -> changeset
    end
  end

  defp confirm_passwords_match(%{changes: %{
    password: password,
    password_confirmation: password_confirmation
  }} = changeset) do
    case password == password_confirmation do
      true ->
        changeset
      false ->
        add_error(changeset, :password_confirmation, "must match password")
    end
  end

  defp create_password_hash(%{changes: %{password: password}} = changeset) do
    change(changeset, hashed_password: Bcrypt.hashpwsalt(password))
  end
  defp create_password_hash(changeset), do: changeset

  defp create_slug(%{changes: %{slug: slug}} = changeset) do
    change(changeset, slug: Slugger.slugify_downcase(slug))
  end
  defp create_slug(changeset), do: changeset
end