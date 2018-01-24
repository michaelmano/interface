use Mix.Config
# General application configuration
config :interface,
  ecto_repos: [Interface.Repo]

# Import configs. these must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "config.secret.exs"
import_config "#{Mix.env}.exs"
