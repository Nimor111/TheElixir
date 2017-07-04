defmodule TheElixir.Models.Room do
  @moduledoc """
  A model for the game's rooms
  """

  alias TheElixir.Models.Room
  
  defstruct [:name, :quests]
  
  @doc """
  Create a new room.
  `name` : name of the room
  `quests` : the quests to be completed in the room to exit
  """
  def new(name, quests \\ %{}) do
    %Room{name: name, quests: quests}
  end

  def add_quest(room, quest_name, quest) do
    Map.put(room.quests, quest_name, quest)
  end
end
