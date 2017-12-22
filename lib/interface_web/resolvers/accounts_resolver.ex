defmodule InterfaceWeb.AccountsResolver do
    alias Interface.Accounts
  
    def all_users(_root, _args, _info) do
      users = Accounts.list_users()
      {:ok, users}
    end

    def get_user(_root, args, _info) do
      user = Accounts.get_user!(args[:id])
      {:ok, user}
    end
end