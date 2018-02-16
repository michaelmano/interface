defmodule Interface.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :hashed_password, :string
      add :slug, :string
      add :avatar, :string, default: "http://lorempixel.com/200/200/people/"
      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:slug])
  end
end
