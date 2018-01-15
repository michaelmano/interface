defmodule Interface.InterfaceWeb.Plugs.Context do
    @behaviour Plug
    import Plug.Conn
    def init(opts) do
        IO.puts("TRYING TO FIGUIRE THIS SHT OUT")
        opts
    end

    def call(conn, _) do
        case Guardian.Plug.current_resource(conn) do
            nil -> conn
            user -> put_private(conn, :absinthe, %{context: %{current_user: user}})
        end
    end
end