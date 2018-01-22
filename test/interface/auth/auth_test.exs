defmodule Interface.AuthTest do
  use Interface.DataCase

  alias Interface.Auth

  describe "failed_login_attempts" do
    alias Interface.Auth.FailedLoginAttempts

    @valid_attrs %{attempts: 42, ip: "some ip"}
    @update_attrs %{attempts: 43, ip: "some updated ip"}
    @invalid_attrs %{attempts: nil, ip: nil}

    def failed_login_attempts_fixture(attrs \\ %{}) do
      {:ok, failed_login_attempts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_failed_login_attempts()

      failed_login_attempts
    end

    test "list_failed_login_attempts/0 returns all failed_login_attempts" do
      failed_login_attempts = failed_login_attempts_fixture()
      assert Auth.list_failed_login_attempts() == [failed_login_attempts]
    end

    test "get_failed_login_attempts!/1 returns the failed_login_attempts with given id" do
      failed_login_attempts = failed_login_attempts_fixture()
      assert Auth.get_failed_login_attempts!(failed_login_attempts.id) == failed_login_attempts
    end

    test "create_failed_login_attempts/1 with valid data creates a failed_login_attempts" do
      assert {:ok, %FailedLoginAttempts{} = failed_login_attempts} = Auth.create_failed_login_attempts(@valid_attrs)
      assert failed_login_attempts.attempts == 42
      assert failed_login_attempts.ip == "some ip"
    end

    test "create_failed_login_attempts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_failed_login_attempts(@invalid_attrs)
    end

    test "update_failed_login_attempts/2 with valid data updates the failed_login_attempts" do
      failed_login_attempts = failed_login_attempts_fixture()
      assert {:ok, failed_login_attempts} = Auth.update_failed_login_attempts(failed_login_attempts, @update_attrs)
      assert %FailedLoginAttempts{} = failed_login_attempts
      assert failed_login_attempts.attempts == 43
      assert failed_login_attempts.ip == "some updated ip"
    end

    test "update_failed_login_attempts/2 with invalid data returns error changeset" do
      failed_login_attempts = failed_login_attempts_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_failed_login_attempts(failed_login_attempts, @invalid_attrs)
      assert failed_login_attempts == Auth.get_failed_login_attempts!(failed_login_attempts.id)
    end

    test "delete_failed_login_attempts/1 deletes the failed_login_attempts" do
      failed_login_attempts = failed_login_attempts_fixture()
      assert {:ok, %FailedLoginAttempts{}} = Auth.delete_failed_login_attempts(failed_login_attempts)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_failed_login_attempts!(failed_login_attempts.id) end
    end

    test "change_failed_login_attempts/1 returns a failed_login_attempts changeset" do
      failed_login_attempts = failed_login_attempts_fixture()
      assert %Ecto.Changeset{} = Auth.change_failed_login_attempts(failed_login_attempts)
    end
  end
end
