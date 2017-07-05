defmodule TheElixir.Logic.Game do
  @moduledoc """
  Module to handle the main menus and text of the game
  """
  
  alias TheElixir.Logic.NewGame 
  alias TheElixir.Logic.Game
  alias TheElixir.Lobby
 
  def game_introduction(player) do
    IO.puts([
      "|>|>|>|>|>|>|>|>|>|>|>|>\n",
      "Hello #{player.name}, and welcome to the world of The Elixir.\n",
      "You are embarking on an exciting adventure down the road of Elixir,\n"
      "A functional, concurrent, and fun book of spells to learn!\n",
      "And now... let's begin!\n",
      "|>|>|>|>|>|>|>|>|>|>|>|>"
    ])
    Game.hallway_introduction(player)
  end

  def hallway_introduction(player) do
    IO.puts([ 
      "|>|>|>|>|>|>|>|>|>|>|>|>\n",
      "You find yourself in a hallway, the walls are lined with symbols.\n",
      "You try to decipher them with your primitive imperative knowledge\n",
      "But they all look so unfamiliar, the one you see the most is |>, and\n",
      "you begin to wonder what it is. You seem to like it. You want\n",
      "to know more. There is a door to your right. What do you do?",
      "|>|>|>|>|>|>|>|>|>|>|>|>"
    ])
    Game.hallway_options(player)
  end

  def hallway_options(player) do
    IO.puts([
      "1. Move forward.\n",
      "2. Inspect your surroundings.\n",
      "3. Look at the door.\n",
      "4. Give up ( would you ever do that? )",
    ])
    choice = Integer.parse(IO.gets("Enter your choice: "))
    player |> Game.choose_option(choice)
  end

  def choose_hallway_option(player, choice) do
    rooms = World.get(:world)
    case choice do 
      1 -> Game.move(player) 
      2 -> Game.inspect(player)
      3 -> {room_name, room} = Game.room(rooms, player)
        Trigger.enter_room_trigger(:world, room_name, room)
      4 -> Lobby.exit
    end
  end
  
  def move(player) do
    IO.puts("You moved forward.")
    Lobby.hallway_options(player)
  end

  def inspect(player) do
    IO.puts("There is a door next to you. Maybe it leads somewhere?")
    Lobby.hallway_options(player)
  end
end
