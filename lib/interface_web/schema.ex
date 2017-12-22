defmodule InterfaceWeb.Schema do
    use Absinthe.Schema
  
    alias InterfaceWeb.AvatarsResolver
    alias InterfaceWeb.AccountsResolver

    object :user do
        field :id, non_null(:id)
        field :name, non_null(:string)
        field :email, non_null(:string)
        field :characters, list_of(:character)
    end
  
    object :character do
      field :id, non_null(:id)
      field :name, non_null(:string)
      field :bio, non_null(:string)
    end
  
    query do
        field :all_users, non_null(list_of(non_null(:user))) do
            resolve &AccountsResolver.all_users/3
        end

        field :all_characters, non_null(list_of(non_null(:character))) do
            resolve &AvatarsResolver.all_characters/3
        end

        field :user, non_null(:user) do
            arg :id, non_null(:integer)
            resolve &AccountsResolver.get_user/3
        end
      end
end
  