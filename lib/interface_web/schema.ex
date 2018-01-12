defmodule InterfaceWeb.Schema do
    use Absinthe.Schema
    use Absinthe.Ecto, repo: Interface.Repo
  
    alias InterfaceWeb.AvatarsResolver
    alias InterfaceWeb.AccountsResolver
    alias Interface.Accounts.User

    
    input_object :user_params do
        field :name, :string
        field :email, :string
        field :password, :string
        field :password_confirmation, :string
    end
    
    object :session do
        field :token, :string
    end

    object :user do
        field :id, non_null(:id)
        field :slug, non_null(:string)
        field :name, non_null(:string)
        field :email, non_null(:string)
    end
  
    object :class do
        field :id, non_null(:id)
        field :name, non_null(:string)
        field :description, non_null(:string)
        field :excerpt, non_null(:string)
    end

    mutation do
        field :login, type: :session do
            arg :email, non_null(:string)
            arg :password, non_null(:string)
            resolve &MyApp.UserResolver.login/2
        end

        field :create_user, :user do
            arg :name, :string
            arg :email, :string
            arg :password, :string
            arg :password_confirmation, :string
            resolve &AccountsResolver.create_user/3
        end
        
        field :update_user, type: :user do
            arg :id, non_null(:integer)
            arg :user, :user_params
            resolve &AccountsResolver.update/3
        end
    end

    query do
        field :users, list_of(:user) do
            resolve &AccountsResolver.all_users/3
        end

        field :classes, list_of(:class) do
            resolve &AvatarsResolver.all_classes/3
        end

        field :user, :user do
            arg :id, :integer
            arg :slug, :string
            resolve &AccountsResolver.get_user/3
        end
    end
end
  