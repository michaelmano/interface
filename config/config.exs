# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :interface,
  ecto_repos: [Interface.Repo]

# Configures the endpoint
config :interface, InterfaceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+oxVNYzCtJy5QYMS+xkl+eirNN0RnPiGnVJR9e2kmzxgD/LceGnRyOuzrVDz9AX5",
  render_errors: [view: InterfaceWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Interface.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
