defmodule TodolistWeb.TasksController do
  use TodolistWeb, :controller

  alias Todolist.Directory
  alias Todolist.Directory.Tasks

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    taskes = Directory.list_taskes()
    render(conn, "index.json", taskes: taskes)
  end

  def create(conn, %{"tasks" => tasks_params}) do
    with {:ok, %Tasks{} = tasks} <- Directory.create_tasks(tasks_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tasks_path(conn, :show, tasks))
      |> render("show.json", tasks: tasks)
    end
  end

  def show(conn, %{"id" => id}) do
    tasks = Directory.get_tasks!(id)
    render(conn, "show.json", tasks: tasks)
  end

  def update(conn, %{"id" => id, "tasks" => tasks_params}) do
    tasks = Directory.get_tasks!(id)

    with {:ok, %Tasks{} = tasks} <- Directory.update_tasks(tasks, tasks_params) do
      render(conn, "show.json", tasks: tasks)
    end
  end

  def delete(conn, %{"id" => id}) do
    tasks = Directory.get_tasks!(id)

    with {:ok, %Tasks{}} <- Directory.delete_tasks(tasks) do
      send_resp(conn, :no_content, "")
    end
  end
end
