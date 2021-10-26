defmodule Todolist.Repo.Migrations.CreateTaskes do
  use Ecto.Migration

  def change do
    create table(:taskes) do
      add :name, :string
      add :description, :text
      add :tag, :string

      timestamps()
    end

  end
end
