defmodule Interface.Auth do
  @moduledoc """
  The Auth context.
  """
  import Ecto.Query, warn: false
  alias Interface.Repo

  alias Interface.Auth.FailedLoginAttempts

  @doc """
  Generates or updates a failed login attempt.
  """
  def failed_login_attempt(params) do
    ip = params.ip
    |> :inet_parse.ntoa()
    |> to_string()

    get_failed_login_attempts!(ip)
    |> case do
      nil -> create_failed_login_attempts(%{ip: ip, attempts: 1})
      response -> 
    end
  end

  @doc """
  Returns the list of failed_login_attempts.

  ## Examples

      iex> list_failed_login_attempts()
      [%FailedLoginAttempts{}, ...]

  """
  def list_failed_login_attempts do
    Repo.all(FailedLoginAttempts)
  end

  @doc """
  Gets a single failed_login_attempts.

  Raises `Ecto.NoResultsError` if the Failed login attempts does not exist.

  ## Examples

      iex> get_failed_login_attempts!(123)
      %FailedLoginAttempts{}

      iex> get_failed_login_attempts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_failed_login_attempts!(ip) do
    FailedLoginAttempts
    |> where([f], f.ip == ^ip)
    |> Repo.one
  end

  @doc """
  Creates a failed_login_attempts.

  ## Examples

      iex> create_failed_login_attempts(%{field: value})
      {:ok, %FailedLoginAttempts{}}

      iex> create_failed_login_attempts(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_failed_login_attempts(attrs \\ %{}) do
    %FailedLoginAttempts{}
    |> FailedLoginAttempts.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a failed_login_attempts.

  ## Examples

      iex> update_failed_login_attempts(failed_login_attempts, %{field: new_value})
      {:ok, %FailedLoginAttempts{}}

      iex> update_failed_login_attempts(failed_login_attempts, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_failed_login_attempts(%FailedLoginAttempts{} = failed_login_attempts, attrs) do
    failed_login_attempts
    |> FailedLoginAttempts.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FailedLoginAttempts.

  ## Examples

      iex> delete_failed_login_attempts(failed_login_attempts)
      {:ok, %FailedLoginAttempts{}}

      iex> delete_failed_login_attempts(failed_login_attempts)
      {:error, %Ecto.Changeset{}}

  """
  def delete_failed_login_attempts(%FailedLoginAttempts{} = failed_login_attempts) do
    Repo.delete(failed_login_attempts)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking failed_login_attempts changes.

  ## Examples

      iex> change_failed_login_attempts(failed_login_attempts)
      %Ecto.Changeset{source: %FailedLoginAttempts{}}

  """
  def change_failed_login_attempts(%FailedLoginAttempts{} = failed_login_attempts) do
    FailedLoginAttempts.changeset(failed_login_attempts, %{})
  end
end
