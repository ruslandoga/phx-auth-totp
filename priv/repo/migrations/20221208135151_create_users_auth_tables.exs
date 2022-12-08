defmodule App.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    create table(:users, options: "STRICT") do
      add :email, :string, null: false, collate: :nocase
      add :hashed_password, :string, null: false
      add :confirmed_at, :string
      add :inserted_at, :string, null: false
      add :updated_at, :string, null: false
    end

    create unique_index(:users, [:email])

    create table(:users_tokens, options: "STRICT") do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false, size: 32
      add :context, :string, null: false
      add :sent_to, :string
      add :inserted_at, :string, null: false
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
