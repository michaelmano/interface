use Mix.Config
# Configure your database
config :elixir_stream, ElixirStream.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "DATABASE_USERNAME",
  password: "DATABASE_PASSWORD",
  database: "DATABASE_NAME",
  size: 20 # The amount of database connections in the pool
