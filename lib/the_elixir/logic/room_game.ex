defmodule TheElixir.Logic.RoomGame do
  @moduledoc """
  Module to handle room logic
  """
  
  alias TheElixir.Logic.RoomGame 
  alias TheElixir.Components.World
  alias TheElixir.Components.Journal
  alias TheElixir.Logic.Game

  def pick_room(player, room_name) do
    # TODO add progress logic
    player |> RoomGame.enter(room_name)
  end

  def enter(player, room_name) do
    # TODO add different room intros, take from some text file maybe
    IO.puts(
      """
      Welcome to the #{room_name} room! This is the first room that you are going to
      encounter, and your great adventure begins here! Each room contains quests that
      you need to finish in order to exit, because oh noes! the room was locked the minute
      you stepped in! We got you, didn't we? Now, look around and start solving tasks!
      """)
    {:ok, room} = World.lookup(:world, room_name)
    player |> RoomGame.get_input(room)
  end

  def get_input(player, room) do
    input = IO.gets("(press h for help) >> ") |> String.strip
    player |> RoomGame.match_input(input, room)
  end

  def match_input(player, input, room) do
    case input do
      "q" -> 
        player |> RoomGame.show_quests(room)
      "add" ->
        player |> RoomGame.add_quest(room)
      "j" ->
        Game.get_journal(player)
      _ ->
        IO.puts "We don't know this command ( yet ). Read the prompt!"
        player |> RoomGame.get_input(room)
    end 
  end

  def show_quests(player, room) do
    Enum.each room.quests, fn {_, v} -> IO.puts "#{v}" end
    player |> RoomGame.get_input(room)
  end

  def add_quest(player, room) do
    quest_name = IO.gets("(Which quest would you like to begin?) >> ") |> String.strip
    case Map.fetch(room.quests, quest_name) do
      {:ok, quest} ->
        Journal.add(:journal, quest_name, quest)
        player |> RoomGame.get_input(room)
      :error ->
        IO.puts "No such quest in this room!"
        player |> RoomGame.add_quest(room)
    end
  end
end
