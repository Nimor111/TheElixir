defmodule TheElixir.Repo.Migrations.CreateQuest do
  use Ecto.Migration

  def change do
    create table(:quests) do
      add :name, :string
      add :description, :string
      add :rewards, {:array, :map}
      add :status, :string
      timestamps()
    end
  end
end
