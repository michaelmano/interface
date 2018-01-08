defmodule Interface.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string
      add :description, :text
      add :excerpt, :text

      timestamps()
    end

  end
end
