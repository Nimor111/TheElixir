defmodule TheElixir.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :description, :string
      timestamps()
    end

    alter table(:quests) do
      add :room_id, references(:rooms)
    end
  end
end
