defmodule LexitApiWeb.Router do
  use LexitApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Corsica, origins: "*"
  end

  scope "/", LexitApiWeb do
    pipe_through :api
    post "/convert_text", ProjectController, :convert_text
  end
end
