#!/bin/bash
# Entrypoint for the Interface Elixir Application.
args=$@

main()
{
  source .env
  if [[ " ${args[@]} " =~ "--refresh" ]]; then
    refresh
  fi
  dev
}

# Start the application with the iex terminal
dev()
{
  iex -S mix phx.server
}

# Refresh the database and re run all of the seeds.
refresh()
{
  mix ecto.reset
}

main
