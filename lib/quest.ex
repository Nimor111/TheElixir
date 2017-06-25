defmodule Quest do
  @moduledoc """
  Module for the quests in the game
  """
  defstruct [:name, :description, :rewards, :status]

  def new(name \\ "", description \\ "", rewards \\ []) do
    %Quest{name: name, description: description, rewards: rewards, status: 'active'}
  end
end
