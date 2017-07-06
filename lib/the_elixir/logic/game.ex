defmodule TheElixir.Logic.Game do
  @moduledoc """
  Module to handle the main menus and text of the game
  """
  
  alias TheElixir.Logic.NewGame
  alias TheElixir.Logic.Game
  alias TheElixir.Lobby
  alias TheElixir.Components.World
  alias TheElixir.Components.Inventory
  alias TheElixir.Logic.Trigger

  def command_help do
    [
      "m -> move forward",
      "i -> inspect surroundings",
      "w -> enter nearest room",
      "e -> exit / quit",
      "inv -> view inventory",
      "world -> view all rooms in the world",
      "j -> view journal"
    ]
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
      "inv" -> IO.puts(Inventory.get(:inventory))
        Game.get_input(player)
      "world" -> IO.puts(World.get(:world))
        Game.get_input(player)
      "j" -> IO.puts(Journal.get(:journal))
        Game.get_input(player)
    end 
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
    Game.hallway_options(player)
  end

  def hallway_options(player) do
    Lobby.clear_screen
    IO.puts([
      "1. Move forward.\n",
      "2. Inspect your surroundings.\n",
      "3. Look at the door.\n",
      "4. Give up ( would you ever do that? )",
    ])
    choice = Integer.parse(IO.gets("Enter your choice: ")) |> elem(0)
    player |> Game.choose_hallway_option(choice)
  end

  def choose_hallway_option(player, choice) do
    rooms = World.get(:world)
    case choice do 
      1 -> Game.move(player) 
      2 -> Game.inspect(player)
      3 -> {room_name, room} = Game.room(rooms, player)
        Trigger.enter_room_trigger(:world, room_name, room)
        IO.puts("You entered the room!")
      4 -> Lobby.exit
      _ -> IO.puts("Choose from the avaliable choices, adventurer.")
        Game.hallway_options(player)
    end
  end
  
  def move(player) do
    IO.puts("You moved forward.")
    Game.hallway_options(player)
  end

  def inspect(player) do
    IO.puts("There is a door next to you. Maybe it leads somewhere?")
    Game.hallway_options(player)
  end

  def room(rooms, player) when rooms == [], do: {"", nil}
  def room(rooms, player) do
    [ room_name | rooms ] = rooms
    {room_name, World.lookup(:world, room_name)}
  end
end
