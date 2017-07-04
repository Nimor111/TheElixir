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
  
  @doc """
  Add a `quest` to the room
  """
  def add_quest(room, quest_name, quest) do
    %Room{name: room.name, quests: Map.put(room.quests, quest_name, quest)}
  end

  def complete_quest(room, quest_name) do
    %Room{name: room.name, quests: Map.pop(room.quests, quest_name) |> elem(1)}
  end

  def exit?(room) do
    room.quests == []
  end
end
