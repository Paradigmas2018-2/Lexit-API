defmodule LexitApiWeb.Router do
  use LexitApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LexitApiWeb do
    pipe_through :api
    resources "/projects", ProjectController, except: [:new, :edit]
  end
end
