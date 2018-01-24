use Mix.Config

config :interface, InterfaceWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

# Configures the endpoint
config :interface, InterfaceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: InterfaceWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Interface.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure your database
config :elixir_stream, ElixirStream.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: System.get_env("DATABASE_USERNAME"),
  password: System.get_env("DATABASE_PASSWORD"),
  database: System.get_env("DATABASE_NAME"),
  size: 20 # The amount of database connections in the pool
