defmodule TheElixir.EctoModels.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias TheElixir.EctoModels.Task

  schema "questions" do
    field :description, :string
    field :choices, :map 
    field :answer, :integer 
    belongs_to :task, Task
    timestamps()
  end

  def changeset(question, params \\ %{}) do
    question
    |> cast(params, [:description, :choices])
  end
end
