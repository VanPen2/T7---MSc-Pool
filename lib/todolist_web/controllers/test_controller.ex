defmodule TodolistWeb.TestController do
  use TodolistWeb, :controller

  def index(conn, _params) do
    render(conn, "test.html.eex")
  end
end
