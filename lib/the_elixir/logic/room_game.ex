defmodule TheElixir.Logic.RoomGame do
  @moduledoc """
  Module to handle room logic
  """
  
  alias TheElixir.Logic.RoomGame 
  alias TheElixir.Components.World
  alias TheElixir.Components.Journal
  alias TheElixir.Components.Inventory
  alias TheElixir.Logic.Game
  alias TheElixir.Lobby

  @doc """
  Pick a room to enter, according to player progress
  Note, this is a TODO feature, for now it picks the only room
  """
  def pick_room(player, room_name) do
    # TODO add progress logic
    player |> RoomGame.enter(room_name)
  end

  @doc """
  Text that appears on entering the room, another TODO is 
  add different intros for different rooms
  """
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

  @doc """
  All commands the `player` can execute in the `room`
  On key press `h`
  """
  def command_help(player, room) do
    IO.puts([
      "m -> move forward\n",
      "i -> inspect surroundings\n",
      "e -> exit / quit\n",
      "inv -> view inventory\n",
      "world -> view all rooms in the world\n",
      "q -> view quests in the room\n",
      "add -> add a quest to your journal\n",
      "j -> view journal\n",
      "c -> clear screen\n"
    ])
    player |> RoomGame.get_input(room)
  end

  @doc """
  Same as get journal in Game, TODO refactor, be DRY
  """
  def get_journal(player, room) do
    quests = Journal.get(:journal)
    case quests do
      [] -> IO.puts("No entries yet.")
      _  -> IO.puts(quests)
    end
    player |> RoomGame.get_input(room)
  end

  @doc """
  Same as get input in Game, get player input, send it to match
  """
  def get_input(player, room) do
    input = IO.gets("(press h for help) >> ") |> String.strip
    player |> RoomGame.match_input(input, room)
  end

  @doc """
  Clear the screen
  On key press `c`
  """
  def clear_screen(player, room) do
    IO.puts("Clearing screen...")
    :timer.sleep(1000)
    System.cmd "clear", [], into: IO.stream(:stdio, :line)
    player |> RoomGame.get_input(room)
  end
  
  @doc """
  Get inventory of `player`
  On key press `inv`
  """
  def get_inventory(player, room) do
    items = Inventory.get(:inventory)
    case items do
      [] -> IO.puts("No items yet.")
      _  -> IO.puts(items)
    end
    player |> RoomGame.get_input(room)
  end

  @doc """
  Get input of player and match it with correct function or try again
  """
  def match_input(player, input, room) do
    case input do
      "q" -> 
        player |> RoomGame.show_quests(room)
      "add" ->
        player |> RoomGame.add_quest(room)
      "j" ->
        player |> RoomGame.get_journal(room)
      "h" ->
        player |> RoomGame.command_help(room)
      "e" ->
        Lobby.exit
      "c" ->
        player |> RoomGame.clear_screen(room) 
      "inv" ->
        player |> RoomGame.get_inventory(room)
      _ ->
        IO.puts "We don't know this command ( yet ). Read the prompt!"
        player |> RoomGame.get_input(room)
    end 
  end

  @doc """
  Show the quests in the room, akin to looking around it
  """
  def show_quests(player, room) do
    Enum.each room.quests, fn {_, v} -> IO.puts "#{v}" end
    player |> RoomGame.get_input(room)
  end

  @doc """
  Start a quest, akin to picking it up and starting it
  """
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
