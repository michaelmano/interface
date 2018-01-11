defmodule InterfaceWeb.Schema do
    use Absinthe.Schema
    use Absinthe.Ecto, repo: Interface.Repo
  
    alias InterfaceWeb.AvatarsResolver
    alias InterfaceWeb.AccountsResolver
    alias Interface.Accounts.User

    object :user do
        field :id, non_null(:id)
        field :slug, non_null(:string)
        field :name, non_null(:string)
        field :email, non_null(:string)
        field :characters, list_of(:character), resolve: assoc(:characters)
    end
  
    object :class do
        field :id, non_null(:id)
        field :name, non_null(:string)
        field :description, non_null(:string)
        field :excerpt, non_null(:string)
    end

    object :character do
      field :id, non_null(:id)
      field :name, non_null(:string)
      field :bio, non_null(:string)
      belongs_to :user, User
      field :class, non_null(:class), resolve: assoc(:class)
    end
  
    query do
        field :users, list_of(:user) do
            resolve &AccountsResolver.all_users/3
        end

        field :characters, list_of(:character) do
            resolve &AvatarsResolver.all_characters/3
        end

        field :classes, list_of(:class) do
            resolve &AvatarsResolver.all_classes/3
        end

        field :user, :user do
            arg :id, :integer
            arg :slug, :string
            resolve &AccountsResolver.get_user/3
        end

        field :create_user, :user do
            arg :name, non_null(:string)
            arg :email, non_null(:string)
            arg :password, non_null(:string)
            arg :password_confirmation, non_null(:string)
            resolve &AccountsResolver.create_user/3
        end
    end
end
  