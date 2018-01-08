defmodule Interface.Repo.Migrations.AbilityTable do
  use Ecto.Migration

  def change do
    create table(:ability) do
      add :name, :string
      add :description, :text
      timestamps()
    end
    create index(:ability)
  end
end
