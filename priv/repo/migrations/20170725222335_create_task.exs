defmodule TheElixir.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :description, :string
      add :goal, :integer
      add :completed_questions, :integer
      add :quest_id, references(:quests)
      timestamps()
    end

    end
end
