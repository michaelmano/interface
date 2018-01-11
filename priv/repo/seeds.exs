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

alias Interface.Avatars.Class
alias Interface.Repo

%Class{name: "Barbarian", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Bard", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Cleric", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Druid", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Fighter", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Monk", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Paladin", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Ranger", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Sorcerer", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Rogue", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Warlock", description: "", excerpt: ""} |> Repo.insert!
%Class{name: "Wizard", description: "", excerpt: ""} |> Repo.insert!