defmodule TheElixir.EctoModels.Task do
  use Ecto.Schema 
  import Ecto.Changeset

  alias TheElixir.EctoModels.Quest

  schema "tasks" do
    field :name, :string
    field :description, :string
    field :goal, :integer
    field :completed_questions, :integer, default: 0
    belongs_to :quest, Quest
    timestamps()
  end

  def changeset(task, params \\ %{}) do
    task
    |> cast(params, [:name, :description, :goal, :completed_questions])
  end
end
