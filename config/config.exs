use Mix.Config
# General application configuration
# You must have an .env file present, If you have not set one up yet you may copy the 
# .env.example and edit the variables to suit. Then run `source .env` before 
# starting the application or ./run.sh to start the application. 

config :interface,
  ecto_repos: [Interface.Repo]

# Configures Guardian
config :interface, InterfaceWeb.Auth.Token,
  issuer: "Interface",
  hooks: Guardian.DB,
  secret_key: System.get_env("GUARDIAN_SECRET"),
  token_ttl: %{
    "refresh" => {365, :days},
    "access" => {7, :days},
  }

# Configures GuardianDB
config :guardian, Guardian.DB,
  repo: Interface.Repo,
  schema_name: "guardian_tokens", # default
  token_types: ["refresh_token"], # store all token types if not set
  sweep_interval: 60 # default: 60 minutes

# Configures the endpoint
config :interface, InterfaceWeb.Endpoint,
  secret_key_base: System.get_env("APPLICATION_SECRET")

# Import configs. these must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
