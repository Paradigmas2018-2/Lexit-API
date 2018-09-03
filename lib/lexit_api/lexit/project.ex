defmodule LexitApi.Lexit.Project do
  use Ecto.Schema
  import Ecto.Changeset


  schema "projects" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
