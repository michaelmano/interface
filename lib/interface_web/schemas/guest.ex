defmodule InterfaceWeb.Schemas.Guest do
    use Absinthe.Schema
    use Absinthe.Ecto, repo: Interface.Repo
  
    alias InterfaceWeb.AccountsResolver

    object :user do
      field :id, non_null(:id)
      field :slug, non_null(:string)
      field :name, non_null(:string)
      field :email, non_null(:string)
    end
  
    query do
      field :user, :user do
          arg :id, :integer
          arg :name, :string
          arg :slug, :string
          resolve &AccountsResolver.get_user/3
      end
    end
end
  