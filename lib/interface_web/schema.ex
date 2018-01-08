defmodule InterfaceWeb.Schema do
    use Absinthe.Schema
    use Absinthe.Ecto, repo: Interface.Repo
  
    alias InterfaceWeb.AvatarsResolver
    alias InterfaceWeb.AccountsResolver
    alias Interface.Accounts.User

    object :user do
        field :id, non_null(:id)
        field :name, non_null(:string)
        field :email, non_null(:string)
        field :characters, list_of(:character), resolve: assoc(:characters)
    end
  
    object :character do
      field :id, non_null(:id)
      field :name, non_null(:string)
      field :bio, non_null(:string)
      belongs_to :user, User
    end
  
    query do
        field :all_users, list_of(:user) do
            resolve &AccountsResolver.all_users/3
        end

        field :all_characters, list_of(:character) do
            resolve &AvatarsResolver.all_characters/3
        end

        field :user, :user do
            arg :id, non_null(:integer)
            resolve &AccountsResolver.get_user/3
        end
    end
end
  