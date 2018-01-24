use Mix.Config
# Configure your database
config :interface, Interface.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "DATABASE_USERNAME",
  password: "DATABASE_PASSWORD",
  database: "DATABASE_NAME",
  hostname: "localhost",
  pool_size: 20
