defmodule TodolistWeb.TasksView do
  use TodolistWeb, :view
  alias TodolistWeb.TasksView

  def render("index.json", %{taskes: taskes}) do
    %{data: render_many(taskes, TasksView, "tasks.json")}
  end

  def render("show.json", %{tasks: tasks}) do
    %{data: render_one(tasks, TasksView, "tasks.json")}
  end

  def render("tasks.json", %{tasks: tasks}) do
    %{id: tasks.id,
      name: tasks.name,
      description: tasks.description,
      tag: tasks.tag}
  end
end
