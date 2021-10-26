defmodule TodolistWeb.Router do
  use TodolistWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug(CORSPlug, origin: "*")
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", TodolistWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/test", TestController, :index
    resources "/tasks", TasksController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
  end


  defp put_csrf_token_in_session(conn, _) do
    conn
    |> Plug.Conn.put_req_header("x-csrf-token", Plug.CSRFProtection.get_csrf_token)
    |> put_session("_csrf_token", Process.get(:plug_unmasked_csrf_token))
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodolistWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TodolistWeb.Telemetry
    end
  end
end
