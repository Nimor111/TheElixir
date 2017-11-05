defmodule TheElixir.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do 
      add :name, :string
      add :history, :string
      add :title, :string
      add :progress, :integer
      timestamps()
    end
  end
end
