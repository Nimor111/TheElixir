defmodule TheElixir.Logic.Game do
  @moduledoc """
  Module to handle the main menus and text of the game
  """
  
  alias TheElixir.Logic.NewGame
  alias TheElixir.Logic.Game
  alias TheElixir.Lobby
  alias TheElixir.Components.World
  alias TheElixir.Components.Inventory
  alias TheElixir.Components.Journal
  alias TheElixir.Logic.Trigger

  def command_help(player) do
    IO.puts([
      "m -> move forward\n",
      "i -> inspect surroundings\n",
      "w -> enter nearest room\n",
      "e -> exit / quit\n",
      "inv -> view inventory\n",
      "world -> view all rooms in the world\n",
      "j -> view journal\n",
      "c -> clear screen\n"
    ])
    Game.get_input(player)
  end

  def get_input(player) do
    input = IO.gets("(press h for help) >> ") |> String.strip
    player |> Game.match_input(input)
  end

  def match_input(player, input) do
    rooms = World.get(:world)
    case input do
      "m" -> Game.move(player)
      "i" -> Game.inspect(player)
      "w" -> Game.room(rooms, player)
      "e" -> Lobby.exit
      "inv" -> Game.get_inventory(player)
      "world" -> Game.get_rooms(player)
      "j" -> Game.get_journal(player)
      "h" -> Game.command_help(player)
      "c" -> Game.clear_screen(player)
       _  -> IO.puts "We don't know this command ( yet ). Read the prompt!"
        Game.get_input(player)
    end 
  end

  def clear_screen(player) do
    IO.puts("Clearing screen...")
    :timer.sleep(1000)
    System.cmd "clear", [], into: IO.stream(:stdio, :line)
    Game.get_input(player)
  end

  def get_journal(player) do
    quests = Journal.get(:journal)
    case quests do
      [] -> IO.puts("No entries yet.")
      _  -> IO.puts(quests)
    end
    Game.get_input(player)
  end

  def get_inventory(player) do
    items = Inventory.get(:inventory)
    case items do
      [] -> IO.puts("No items yet.")
      _  -> IO.puts(items)
    end
    Game.get_input(player)
  end

  def get_rooms(player) do
    rooms = World.get(:world)
    case rooms do
      [] -> IO.puts("No rooms yet.")
      _  -> IO.puts("Rooms: \n")
        Enum.each rooms, &IO.puts(&1 <> "\n")
    end
    Game.get_input(player)
  end
 
  def game_introduction(player) do
    IO.puts([
      "|>|>|>|>|>|>|>|>|>|>|>|>\n",
      "Hello #{player.name}, and welcome to the world of The Elixir.\n",
      "You are embarking on an exciting adventure down the road of Elixir,\n",
      "A functional, concurrent, and fun book of spells to learn!\n",
      "And now... let's begin!\n",
      "|>|>|>|>|>|>|>|>|>|>|>|>"
    ])
    Game.hallway_introduction(player)
  end

  def hallway_introduction(player) do
    IO.puts([ 
      "You find yourself in a hallway, the walls are lined with symbols.\n",
      "You try to decipher them with your primitive imperative knowledge\n",
      "But they all look so unfamiliar, the one you see the most is |>, and\n",
      "you begin to wonder what it is. You seem to like it. You want\n",
      "to know more. There is a door to your right. What do you do?\n",
      "|>|>|>|>|>|>|>|>|>|>|>|>"
    ])
    Game.get_input(player)
  end

  def move(player) do
    IO.puts("You moved forward.")
    Game.get_input(player)
  end

  def inspect(player) do
    IO.puts("There is a door next to you. Maybe it leads somewhere?")
    Game.get_input(player)
  end

  def room(rooms, player) when rooms == [], do: "There is no room nearby!"
  def room(rooms, player) do
    RoomGame.pick_room(player, room_name)
  end
end
