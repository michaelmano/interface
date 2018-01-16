defmodule Interface.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Interface.Repo

  alias Interface.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(args) do
    User
    |> determine_user_lookup_method(args)
    |> Repo.one
  end

  defp determine_user_lookup_method(user, %{id: id}), do: user |> where([u], u.id == ^id)
  defp determine_user_lookup_method(user, %{slug: slug}), do: user |> where([u], u.slug == ^slug)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.create_changeset(insert_slug(attrs))
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%{id: id, user: attrs}) do
    Repo.get!(User, id)
    |> User.update_changeset(insert_slug(attrs))
    |> Repo.update
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  # @doc """
  # Returns an `%Ecto.Changeset{}` for tracking user changes.

  # ## Examples

  #     iex> change_user(user)
  #     %Ecto.Changeset{source: %User{}}

  # """
  # def change_user(%User{} = user) do
  #   User.changeset(user, %{})
  # end

  defp insert_slug(attrs) do
    Map.put(attrs, :slug, Map.get(attrs, :name))
  end

  def create_changeset do
    User.create_changeset(%User{}, %{})
  end

  def update_changeset(user) do
    User.update_changeset(user, %{})
  end

  def authenticate(%{email: email, password: password}) do
    User
    |> Repo.get_by(email: email)
    |> validate_and_return_user(password)
  end

  defp validate_and_return_user(nil, _), do: {:invalid, nil}
  defp validate_and_return_user(user, password) do
    User.check_password(user, password)
  end

  def test(args) do
    {:ok, %{name: "the current users name is"}}
  end
end