use Mix.Config

config :interface, InterfaceWeb.Auth.Token,
  secret_key: "SECRET-KEY-HERE" # mix guardian.gen.secret

# Configures the endpoint
config :interface, InterfaceWeb.Endpoint,
  secret_key_base: "SECRET-KEY-HERE"
