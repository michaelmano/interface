defmodule Interface.Auth do
  @moduledoc """
  The Auth context.
  """
  import Ecto.Query, warn: false
  alias Interface.Repo

  alias Interface.Auth.FailedLoginAttempt

  @doc """
  Generates or updates a failed login attempt.
  """
  def failed_login_attempt(params) do
    ip = params.ip
    |> :inet_parse.ntoa()
    |> to_string()

    get_failed_login_attempt!(ip)
    |> case do
      nil -> create_failed_login_attempt(%{ip: ip, attempts: 1})
      response -> increment_failed_login_attempt(response)
    end
  end

  @doc """
  Returns the list of failed_login_attempt.

  ## Examples

      iex> list_failed_login_attempt()
      [%FailedLoginAttempt{}, ...]

  """
  def list_failed_login_attempt do
    Repo.all(FailedLoginAttempt)
  end

  @doc """
  Gets a single failed_login_attempt.

  Raises `Ecto.NoResultsError` if the Failed login attempts does not exist.

  ## Examples

      iex> get_failed_login_attempt!(123)
      %FailedLoginAttempt{}

      iex> get_failed_login_attempt!(456)
      ** (Ecto.NoResultsError)

  """
  def get_failed_login_attempt!(ip) do
    FailedLoginAttempt
    |> where([f], f.ip == ^ip)
    |> Repo.one
  end

  @doc """
  Creates a failed_login_attempt.

  ## Examples

      iex> create_failed_login_attempt(%{field: value})
      {:ok, %FailedLoginAttempt{}}

      iex> create_failed_login_attempt(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_failed_login_attempt(attrs \\ %{}) do
    %FailedLoginAttempt{}
    |> FailedLoginAttempt.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a failed_login_attempt.

  ## Examples

      iex> update_failed_login_attempt(failed_login_attempt, %{field: new_value})
      {:ok, %FailedLoginAttempt{}}

      iex> update_failed_login_attempt(failed_login_attempt, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_failed_login_attempt(%FailedLoginAttempt{} = failed_login_attempt, attrs) do
    failed_login_attempt
    |> FailedLoginAttempt.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FailedLoginAttempt.

  ## Examples

      iex> delete_failed_login_attempt(failed_login_attempt)
      {:ok, %FailedLoginAttempt{}}

      iex> delete_failed_login_attempt(failed_login_attempt)
      {:error, %Ecto.Changeset{}}

  """
  def delete_failed_login_attempt(%FailedLoginAttempt{} = failed_login_attempt) do
    Repo.delete(failed_login_attempt)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking failed_login_attempt changes.

  ## Examples

      iex> change_failed_login_attempt(failed_login_attempt)
      %Ecto.Changeset{source: %FailedLoginAttempt{}}

  """
  def change_failed_login_attempt(%FailedLoginAttempt{} = failed_login_attempt) do
    FailedLoginAttempt.changeset(failed_login_attempt, %{})
  end

  def increment_failed_login_attempt(failed_login_attempt) do
    update_failed_login_attempt(failed_login_attempt, %{attempts: failed_login_attempt.attempts+1})
    cond do
      failed_login_attempt.attempts < 5 -> IO.puts("Attempts under 5.")
      true -> increment_failed_login_timeout(failed_login_attempt)
    end
  end

  def increment_failed_login_timeout(failed_login_attempt) do
    Interface.DateTime.now()
    |> IO.inspect
    |> Interface.DateTime.add(%{minutes: failed_login_attempt.attempts*10})
    |> DateTime.from_unix!(:millisecond)
    |> IO.inspect
  end
end
