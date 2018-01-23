#!/bin/bash
main()
{
  source .env
  PS3='Please enter your choice: '
  options=("Start" "Drop, Create and seed database" "Quit")
  select opt in "${options[@]}"
  do
      case $opt in
          "Start")
              start
              ;;
          "Drop, Create and seed database")
              refreshDB
              ;;
          "Quit")
              break
              ;;
          *) echo invalid option;;
      esac
  done
}

start()
{
  iex -S mix phx.server
}

refreshDB()
{
  mix ecto.drop
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  echo "The database has been refreshed and seeded."
  exit
}

main
