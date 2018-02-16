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

# alias Interface.Repo
alias Interface.Accounts
users = [
  %{name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password", avatar: ""},
  %{name: "Example User3", email: "user3@example.com", password: "3password", password_confirmation: "3password", avatar: ""},
  %{name: "Example User34", email: "user34@example.com", password: "3password", password_confirmation: "3password", avatar: ""},
  %{name: "Example User35", email: "user35@example.com", password: "3password", password_confirmation: "3password", avatar: ""},
  %{name: "Example User36", email: "user36@example.com", password: "3password", password_confirmation: "3password", avatar: ""},
  %{name: "Example User37", email: "user37@example.com", password: "3password", password_confirmation: "3password", avatar: ""},
]
for user <- users, do: Accounts.create_user(user)
