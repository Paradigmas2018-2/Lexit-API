defmodule LexitApi.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:projects, [:name])
  end
end
