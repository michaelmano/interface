# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Interface.Repo.insert!(%Interface.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Interface.Accounts.User
alias Interface.Avatars.Character
alias Interface.Repo

%User{name: "http://graphql.org/", email: "The Best Query Language"} |> Repo.insert!
%User{name: "http://dev.apollodata.com/", email: "Awesome GraphQL Client"} |> Repo.insert!
%Character{name: "meow", bio: "Awesome GraphQL Client", user_id: 2} |> Repo.insert!
%Character{name: "kasd", bio: "Awesome GraphQL Client", user_id: 1} |> Repo.insert!

