use Mix.Config
# General application configuration
config :interface,
  ecto_repos: [Interface.Repo]

# Configures Guardian
config :interface, InterfaceWeb.Auth.Token,
  issuer: "Interface",
  hooks: Guardian.DB,
  token_ttl: %{
    "refresh" => {365, :days},
    "access" => {7, :days},
  }

config :guardian, Guardian.DB,
  repo: Interface.Repo,
  schema_name: "guardian_tokens", # default
  token_types: ["refresh_token"], # store all token types if not set
  sweep_interval: 60 # default: 60 minutes

# Import configs. these must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
import_config "config.secret.exs"
import_config "#{Mix.env}.secret.exs"
