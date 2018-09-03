defmodule LexitApiWeb.ProjectController do
  use LexitApiWeb, :controller

  alias LexitApi.Lexit
  alias LexitApi.Lexit.Project

  action_fallback LexitApiWeb.FallbackController

  def index(conn, _params) do
    projects = Lexit.list_projects()
    render(conn, "index.json", projects: projects)
  end

  def create(conn, %{"project" => project_params}) do
    with {:ok, %Project{} = project} <- Lexit.create_project(project_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", project_path(conn, :show, project))
      |> render("show.json", project: project)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Lexit.get_project!(id)
    render(conn, "show.json", project: project)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Lexit.get_project!(id)

    with {:ok, %Project{} = project} <- Lexit.update_project(project, project_params) do
      render(conn, "show.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Lexit.get_project!(id)
    with {:ok, %Project{}} <- Lexit.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
