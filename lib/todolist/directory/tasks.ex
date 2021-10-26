defmodule Todolist.Directory.Tasks do
  use Ecto.Schema
  import Ecto.Changeset

  schema "taskes" do
    field :description, :string
    field :name, :string
    field :tag, :string

    timestamps()
  end

  @doc false
  def changeset(tasks, attrs) do
    tasks
    |> cast(attrs, [:name, :description, :tag])
    |> validate_required([:name, :description, :tag])
  end
end
