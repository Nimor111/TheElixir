defmodule TheElixir.Models.Quest do
  @moduledoc """
  Module for the quests in the game
  """
  
  alias TheElixir.Models.Quest, as: Quest

  defstruct [:name, :description, :rewards, :status, :tasks]

  def new(name \\ "", description \\ "", rewards \\ [], tasks \\ 5) do
    %Quest{name: name, description: description, rewards: rewards, status: :active, tasks: tasks}
  end
end
