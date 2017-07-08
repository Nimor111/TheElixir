defmodule TheElixir.Models.Task do
  @moduledoc """
  Model to represent a task in the game
  """

  alias TheElixir.Models.Task 
  defstruct [:title, :description, :goal, :status, :completed_questions, :questions]

  @doc """
  Create a Task instance
  `title` : The name of the task
  `description` : The description of the task
  `goal` : How many questions must be answered correctly before task can be completed
  """
  def new(title, description, goal, questions \\ [],
          completed_questions \\ 0) do
    %Task{title: title, description: description, goal: goal,
          status: :active, completed_questions: completed_questions,
          questions: questions}
  end
  
  @doc """
  Display basic information about the task
  """
  def show(task) do
    IO.puts(task.title)
    IO.puts(task.description)
    IO.puts("You have to complete #{task.goal} questions to finish this task.")
  end
  
  @doc """
  Check if `task` has been completed
  """
  def completed?(task) do
    task.completed_questions >= task.goal
  end

  @doc """
  Complete `task`
  """
  def complete(task) do
    %Task{title: task.title, description: task.description, goal: task.goal,
      questions: task.questions, status: :completed,
      completed_questions: task.completed_questions} 
  end

  @doc """
  Check how many question `task` has left
  """
  def questions_left(task) do
    case task.status do
      :active -> task.goal - task.completed_questions
      :completed -> 0
    end
  end
end

defimpl String.Chars, for: TheElixir.Models.Task do
  def to_string(task) do
    task.title
  end 
end
