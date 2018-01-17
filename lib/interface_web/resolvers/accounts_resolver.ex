defmodule InterfaceWeb.AccountsResolver do
  alias Interface.Accounts
  alias Interface.Guardian

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
    case Accounts.authenticate(args) do
      {:ok, user} -> 
        with {:ok, token, _} <- Guardian.encode_and_sign(user, token_type: "access"), do: {:ok, %{token: token}}
      {:error, error} -> {:error, error}
    end
  end

  def logout_user(_root, _args, %{context: user}) do
    with {:ok, claims} = Guardian.revoke(user.header_token) do
      IO.inspect(claims)
    end
    IO.inspect(user)
    {:ok, user}
  end

  def logout_user(_root, _args, _context), do: {:error, "You are not currently logged in."}

  def resolve_user(_root, _args, %{context: user}) do
    {:ok, user}
  end
  def resolve_user(_root, _args, _context), do: {:ok, nil}
end