defmodule TheElixir.EctoModels.Task do
  @moduledoc """
  Module representing a task of a quest
  A quest is comprised of many tasks
  """

  use Ecto.Schema 
  import Ecto.Changeset

  alias TheElixir.EctoModels.Quest
  alias TheElixir.EctoModels.Question

  schema "tasks" do
    field :name, :string
    field :description, :string
    field :goal, :integer
    field :completed_questions, :integer, default: 0
    belongs_to :quest, Quest
    has_many :questions, Question
    timestamps()
  end

  def changeset(task, params \\ %{}) do
    task
    |> cast(params, [:name, :description, :goal, :completed_questions])
  end
end
