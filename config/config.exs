use Mix.Config
# General application configuration
# You must have an .env file present, If you have not set one up yet you may copy the 
# .env.example and edit the variables to suit. Then run `source .env` before 
# starting the application or ./run.sh to start the application. 

config :interface,
  ecto_repos: [Interface.Repo]

# Configures Guardian
config :interface, Interface.Auth,
  issuer: "Interface",
  hooks: Guardian.DB,
  secret_key: System.get_env("GUARDIAN_SECRET"),
  token_ttl: %{
    "refresh" => {System.get_env("GUARDIAN_REFRESH_EXPIRY"), :hours},
    "access" => {System.get_env("GUARDIAN_ACCESS_EXPIRY"), :hours},
  }

# Configures GuardianDB
config :guardian, Guardian.DB,
  repo: Interface.Repo,
  schema_name: "guardian_tokens", # default
  # token_types: ["refresh_token"], # store all token types if not set
  sweep_interval: 60 # default: 60 minutes

# Configures the endpoint
config :interface, InterfaceWeb.Endpoint,
  secret_key_base: System.get_env("APPLICATION_SECRET")

# Import configs. these must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
