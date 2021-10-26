defmodule Todolist.DirectoryTest do
  use Todolist.DataCase

  alias Todolist.Directory

  describe "taskes" do
    alias Todolist.Directory.Tasks

    @valid_attrs %{description: "some description", name: "some name", tag: "some tag"}
    @update_attrs %{description: "some updated description", name: "some updated name", tag: "some updated tag"}
    @invalid_attrs %{description: nil, name: nil, tag: nil}

    def tasks_fixture(attrs \\ %{}) do
      {:ok, tasks} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_tasks()

      tasks
    end

    test "list_taskes/0 returns all taskes" do
      tasks = tasks_fixture()
      assert Directory.list_taskes() == [tasks]
    end

    test "get_tasks!/1 returns the tasks with given id" do
      tasks = tasks_fixture()
      assert Directory.get_tasks!(tasks.id) == tasks
    end

    test "create_tasks/1 with valid data creates a tasks" do
      assert {:ok, %Tasks{} = tasks} = Directory.create_tasks(@valid_attrs)
      assert tasks.description == "some description"
      assert tasks.name == "some name"
      assert tasks.tag == "some tag"
    end

    test "create_tasks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_tasks(@invalid_attrs)
    end

    test "update_tasks/2 with valid data updates the tasks" do
      tasks = tasks_fixture()
      assert {:ok, %Tasks{} = tasks} = Directory.update_tasks(tasks, @update_attrs)
      assert tasks.description == "some updated description"
      assert tasks.name == "some updated name"
      assert tasks.tag == "some updated tag"
    end

    test "update_tasks/2 with invalid data returns error changeset" do
      tasks = tasks_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_tasks(tasks, @invalid_attrs)
      assert tasks == Directory.get_tasks!(tasks.id)
    end

    test "delete_tasks/1 deletes the tasks" do
      tasks = tasks_fixture()
      assert {:ok, %Tasks{}} = Directory.delete_tasks(tasks)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_tasks!(tasks.id) end
    end

    test "change_tasks/1 returns a tasks changeset" do
      tasks = tasks_fixture()
      assert %Ecto.Changeset{} = Directory.change_tasks(tasks)
    end
  end

  describe "users" do
    alias Todolist.Directory.User

    @valid_attrs %{firstname: "some firstname", lastname: "some lastname"}
    @update_attrs %{firstname: "some updated firstname", lastname: "some updated lastname"}
    @invalid_attrs %{firstname: nil, lastname: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Directory.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Directory.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Directory.create_user(@valid_attrs)
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Directory.update_user(user, @update_attrs)
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_user(user, @invalid_attrs)
      assert user == Directory.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Directory.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Directory.change_user(user)
    end
  end
end
