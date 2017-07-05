defmodule TheElixir.Lobby do
  @moduledoc """
  Main lobby for the game
  """
  
  alias TheElixir.Logic.NewGame
  alias TheElixir.Lobby
  alias TheElixir.Logic.Game

  def print_main_menu do
    """ 
    1. New game
    2. Continue
    3. Exit
    """
  end

  def new_game do
    NewGame.init_world
    name = NewGame.enter_name
    history = NewGame.enter_history
    player = NewGame.new_player(name, history)
    Game.game_introduction(player)
  end

  def continue do
    "Nothing for now"
  end

  def exit do
    IO.puts("Goodbye!")
    System.halt(0)
  end

  def loop do
    IO.puts(Lobby.print_main_menu)
    choice = IO.gets("Which do you pick, adventurer? ")
    choice = Integer.parse(choice) |> elem(0)
    case choice do
      1 -> Lobby.new_game
      2 -> IO.puts(Lobby.continue)
      3 -> Lobby.exit
      _   -> IO.puts("Try again!")
             Lobby.loop 
    end
  end

  def clear_screen do
    :timer.sleep(2000)
    System.cmd "clear", [], into: IO.stream(:stdio, :line)
  end
end
