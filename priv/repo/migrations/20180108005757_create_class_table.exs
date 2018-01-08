defmodule Interface.Repo.Migrations.Createclass do
  use Ecto.Migration

  def change do
    create table(:class) do
      add :name, :string
      add :description, :text
      add :excerpt, :text

      timestamps()
    end

    create index(:class)
    """
    http://engl393-dnd5th.wikia.com/wiki/
    https://www.dndbeyond.com/characters/classes/
    name: string
    description: text
    excerpt: text

    # Related
    primary_ability: has_one related
    saving_throws: has_many related
    proficiencies: has_many related
    equipment: has_many related
    skills: has_many related

    # Come back to once understood.
    primal_paths, leveling_up
    """
  end
end
