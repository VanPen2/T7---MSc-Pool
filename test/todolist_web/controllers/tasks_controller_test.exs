defmodule TodolistWeb.TasksControllerTest do
  use TodolistWeb.ConnCase

  alias Todolist.Directory
  alias Todolist.Directory.Tasks

  @create_attrs %{
    description: "some description",
    name: "some name",
    tag: "some tag"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    tag: "some updated tag"
  }
  @invalid_attrs %{description: nil, name: nil, tag: nil}

  def fixture(:tasks) do
    {:ok, tasks} = Directory.create_tasks(@create_attrs)
    tasks
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all taskes", %{conn: conn} do
      conn = get(conn, Routes.tasks_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tasks" do
    test "renders tasks when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tasks_path(conn, :create), tasks: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.tasks_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name",
               "tag" => "some tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tasks_path(conn, :create), tasks: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tasks" do
    setup [:create_tasks]

    test "renders tasks when data is valid", %{conn: conn, tasks: %Tasks{id: id} = tasks} do
      conn = put(conn, Routes.tasks_path(conn, :update, tasks), tasks: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.tasks_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name",
               "tag" => "some updated tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tasks: tasks} do
      conn = put(conn, Routes.tasks_path(conn, :update, tasks), tasks: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tasks" do
    setup [:create_tasks]

    test "deletes chosen tasks", %{conn: conn, tasks: tasks} do
      conn = delete(conn, Routes.tasks_path(conn, :delete, tasks))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.tasks_path(conn, :show, tasks))
      end
    end
  end

  defp create_tasks(_) do
    tasks = fixture(:tasks)
    %{tasks: tasks}
  end
end
