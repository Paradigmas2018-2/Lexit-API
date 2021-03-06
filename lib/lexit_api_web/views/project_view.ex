defmodule LexitApiWeb.ProjectView do
  use LexitApiWeb, :view
  alias LexitApiWeb.ProjectView

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      name: project.name,
      description: project.description}
  end

  def render("convert_text.json", %{result: result}) do
    %{result: result}
  end
end
