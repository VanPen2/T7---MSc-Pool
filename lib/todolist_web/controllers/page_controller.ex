defmodule TodolistWeb.PageController do
  use TodolistWeb, :controller

  def index(conn, _params) do
  conn
    |> put_session(:foo, :bar)
    |> text("")
    render(conn, "index.html")
  end
end
