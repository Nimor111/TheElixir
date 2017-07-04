defmodule TheElixir.Models.Player do
  @moduledoc """
  A module to hold some basic information about the player.
  """ 

  alias TheElixir.Models.Player
  
  defstruct [:name, :history, :title, :progress]
  
  @doc """
  Creates a player.
  `name`: The player's name
  `history`: The player's background and life
  `title`: The title the player had earned while playing, defaults to "the newb"
  `progress`: How many rooms the player has completed, starts at 0, obviously
  """
  def new(name, history \\ "", title \\ "the newb", progress \\ 0) do
    %Player{name: name, history: history, title: title, progress: progress}
  end
  
  @doc """
  Completes a room for a `player`, a.k.a adds 1 to his/her progress
  """
  def add_progress(player) do
    Player.new(player.name, player.history, player.title, player.progress + 1)
  end
end
