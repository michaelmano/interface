# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config
# General application configuration
config :interface,
  ecto_repos: [Interface.Repo]

# Configures Guardian
config :interface, InterfaceWeb.Auth.Token,
  issuer: "Interface",
  hooks: Guardian.DB,
  ttl: { 30, :days },
  secret_key: System.get_env("GUARDIAN_SECRET")

config :guardian, Guardian.DB,
  repo: Interface.Repo,
  schema_name: "guardian_tokens", # default
  # token_types: ["refresh_token"], # store all token types if not set
  sweep_interval: 60 # default: 60 minutes

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
