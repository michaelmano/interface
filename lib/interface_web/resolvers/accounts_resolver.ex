defmodule InterfaceWeb.AccountsResolver do
    alias Interface.Accounts
  
    def all_users(_root, _args, _info) do
      users = Accounts.list_users()
      {:ok, users}
    end

    def get_user(_root, args, _info) do
      user = Accounts.get_user!(args)
      {:ok, user}
    end

    def create_user(_root, args, _info), do: Accounts.create_user(args)

    def update(_root, args, _info), do: Accounts.update_user(args)

    def login(_root, args, _info) do
      with {:ok, user} <- Accounts.authenticate(args),
        {:ok, token, _} <- Interface.Guardian.encode_and_sign(user, token_type: "access") do
          {:ok, %{token: token}}
      end
    end

    def test(_root, args, _info) do
      {:ok, %{name: "the current users name is "}}
    #   with {:ok, claims} <- Interface.Guardian.decode_and_verify(token, %{"typ" => "access"}) do
      
    #   end
    end
end