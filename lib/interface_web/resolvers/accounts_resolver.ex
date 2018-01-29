defmodule InterfaceWeb.AccountsResolver do
  alias Interface.Accounts
  alias Interface.Auth

  def all_users(_root, _args, _info) do
    users = Accounts.list_users()
    {:ok, users}
  end

  def get_user(_root, args, _info) do
    user = Accounts.get_user!(args)
    {:ok, user}
  end

  def update(_root, %{fields: fields}, %{context: user}) do
    Accounts.update_user(user, fields)
  end

  def resolve_user(_root, _args, %{context: user}) do
    {:ok, user}
  end
  def resolve_user(_root, _args, _info), do: {:ok, nil}
end
