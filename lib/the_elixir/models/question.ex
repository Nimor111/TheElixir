defmodule TheElixir.Models.Question do
  @moduledoc """
  A model to represent a question for a task
  """
    
  alias TheElixir.Models.Question

  defstruct [:description, :choices, :answer]

  @doc """
  Create a new question.
  `description`: content of the question
  `choices`: available choices
  `answer`: the correct choice
  """
  def new(description, choices \\ %{}, answer) do
    %Question{description: description, choices: choices, answer: answer}
  end
end
