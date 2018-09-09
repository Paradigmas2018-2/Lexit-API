defmodule LexitApiWeb.Router do
  use LexitApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LexitApiWeb do
    pipe_through :api
    resources "/projects", ProjectController, except: [:new, :edit]
    post "/convert_text", ProjectController, :convert_text
  end
end
