defmodule TheElixir.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :description, :string
      add :choices, :map
      add :answer, :integer
      timestamps()
    end
  end
end
