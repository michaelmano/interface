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
    |> build_query(args)
    |> Repo.one
  end

  defp build_query(user, %{id: id, slug: slug, name: name}) do
    user 
    |> where([u], u.name == ^name) 
    |> where([u], u.id == ^id)
    |> where([u], u.slug == ^slug)
  end

  defp build_query(user, %{id: id}) do
    user |> where([u], u.id == ^id)
  end

  defp build_query(user, %{slug: slug}) do
    user |> where([u], u.slug == ^slug)
  end

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
  def update_user(user, fields) do
    user
    |> User.update_changeset(insert_slug(fields))
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
end
