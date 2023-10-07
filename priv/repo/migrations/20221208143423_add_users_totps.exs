defmodule App.Repo.Migrations.AddUsersTotps do
  use Ecto.Migration

  def change do
    create table(:users_totps, options: "STRICT") do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :secret, :binary
      add :backup_codes, :string
      add :inserted_at, :string, null: false
      add :updated_at, :string, null: false
    end

    create unique_index(:users_totps, [:user_id])
  end
end
