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
          status: :active, completed_questions: 0,
          questions: questions}
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
          status: :completed, completed_questions: task.completed_questions} 
  end

  @doc """
  Check how many question `tasks` has left
  """
  def questions_left(task) do
    case task.status do
      :active -> task.goal - task.completed_questions
      :completed -> 0
    end
  end
end
