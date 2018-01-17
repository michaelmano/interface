defmodule InterfaceWeb.Middleware.Auth.Logout do
    @behaviour Absinthe.Middleware

    def call(resolution, _config) do
        resolution
    end

    def call(resolution, _config) do
        resolution
        |> Absinthe.Resolution.put_result({:error, %{ code: :not_authenticated, error: "Not authenticated",message: "Not authenticated"}})
    end
end