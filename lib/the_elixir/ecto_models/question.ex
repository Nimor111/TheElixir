defmodule TheElixir.EctoModels.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :description, :string
    field :choices, :map 
    field :answer, :integer 
    timestamps()
  end

  def changeset(question, params \\ %{}) do
    question
    |> cast(params, [:description, :choices])
  end
end
