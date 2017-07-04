defmodule TheElixir.Models.Quest do
  @moduledoc """
  Module for the quests in the game
  """
  
  alias TheElixir.Models.Quest

  defstruct [:name, :description, :rewards, :status, :tasks]
  
  @doc """
  Create a new quest
  `name`: name of the quest
  `description`: description of the quest
  `rewards`: items that the quest gives on completion
  `tasks`: amount of tasks to complete to finish the quest
  `status`: :active or :completed
  """
  def new(name \\ "", description \\ "", rewards \\ [], tasks \\ 5) do
    %Quest{name: name, description: description, rewards: rewards, status: :active, tasks: tasks}
  end
  
  @doc """
  Check if `quest` is completed
  """
  def completed?(quest) do
    quest.status == :completed
  end
  
  @doc """
  Complete `quest`
  """
  def complete_quest(quest) do
    %Quest{name: quest.name, description: quest.description, rewards: quest.rewards,
           tasks: quest.tasks, status: :completed}
  end
end
