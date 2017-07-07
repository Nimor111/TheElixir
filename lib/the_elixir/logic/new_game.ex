defmodule TheElixir.Logic.NewGame do
  @moduledoc """
  Module that handles the new game option in the main menu.
  Includes:
  1. Prompt to enter name
  2. Prompt to enter history ( or not )
  3. List of available rooms to enter
  4. Create a player for the game
  """

  alias TheElixir.Components.World
  alias TheElixir.Models.Player
  alias TheElixir.Models.Room
  alias TheElixir.Models.Quest
  alias TheElixir.Models.Task
  alias TheElixir.Models.Question
  
  @doc """
  Inits the world with rooms, one for now
  TODO add more rooms
  """
  def init_world do
    question = Question.new("Is the truth truly the truth? In elixir, true equalswhich one?",
                            %{"1" => "true", "2" => "false"}, "1")
    task = Task.new("Equalities", "We shall see what is truthy and what is not", 1, [question])
    quest = Quest.new("First quest", "Our first adventure!", ["equality"], [task])
    room = Room.new("Introduction")
    room = Room.add_quest(room, "First quest", quest)
    World.add(:world, "Introduction", room)
  end
  
  @doc """
  Prompts the user to enter a name for his character
  """ 
  def enter_name do
    name = IO.gets("Enter your name, brave Elixir adventurer: ") |> String.strip
    name
  end
  
  @doc """
  Prompts the user to enter a history for his character
  """ 
  def enter_history do
    history = IO.gets("Tell us a bit about yourself, adventurer: ") |> String.strip
    history
  end

  @doc """
  Lists all rooms in the `world` available to the player
  in the beginning 
  """ 
  def list_rooms(world) do
    World.get(world)
  end
  
  @doc """
  Creates the player with `name` and `history` 
  after character creation process is over
  """
  def new_player(name, history) do
    player = Player.new(name, history)
    IO.puts("Welcome to The Elixir, #{player.name}!")
    player
  end
end
