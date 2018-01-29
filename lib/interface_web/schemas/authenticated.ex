defmodule InterfaceWeb.Schemas.Authenticated do
  use Absinthe.Schema
  use Absinthe.Ecto, repo: Interface.Repo

  alias InterfaceWeb.AccountsResolver

  input_object :user_params do
    field :name, :string
    field :email, :string
    field :password, :string
    field :password_confirmation, :string
  end

  object :user do
    field :id, non_null(:id)
    field :slug, non_null(:string)
    field :name, non_null(:string)
    field :email, non_null(:string)
  end

  mutation do
    field :update, type: :user do
      arg :fields, :user_params
      resolve &AccountsResolver.update/3
    end
  end

  query do
    field :my, :user do
      resolve &AccountsResolver.resolve_user/3
    end

    field :users, list_of(:user) do
      resolve &AccountsResolver.all_users/3
    end

    field :user, :user do
      arg :id, :integer
      arg :slug, :string
      resolve &AccountsResolver.get_user/3
    end
  end

end
