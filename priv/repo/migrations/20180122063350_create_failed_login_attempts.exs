defmodule Interface.Repo.Migrations.CreateFailedLoginAttempts do
  use Ecto.Migration

  def change do
    create table(:failed_login_attempts) do
      add :ip, :string
      add :attempts, :integer
      add :timeout, :utc_datetime

      timestamps()
    end
    create unique_index(:failed_login_attempts, [:ip])
  end
end
