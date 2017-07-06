defmodule TheElixir.Logic.RoomGame do
  @moduledoc """
  Module to handle room logic
  """
  
  alias TheElixir.Logic.RoomGame 
  alias TheElixir.Components.World

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
    RoomGame.get_input(player, room)
  end

  def get_input(player, room) do
    input = IO.gets("(press h for help) >> ") |> String.strip
    player |> RoomGame.match_input(input, room)
  end

  def match_input(player, input, room) do
    case input do
      "q" -> 
        Enum.each room.quests, fn {_, v} -> IO.puts "#{v}" end
        player |> RoomGame.get_input(room)
      _ ->
        IO.puts "We don't know this command ( yet ). Read the prompt!"
        player |> RoomGame.get_input(room)
    end 
  end


end
