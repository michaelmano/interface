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

%User{name: "Michael", email: "michael@example.com"} |> Repo.insert!
%User{name: "Elizabeth", email: "elizabeth@example.com"} |> Repo.insert!

%Character{name: "meow", bio: "Characters bio here.", user_id: 1, class_id: 1} |> Repo.insert!
%Character{name: "kittens", bio: "Characters bio here.", user_id: 2, class_id: 4} |> Repo.insert!

