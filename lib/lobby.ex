defmodule TheElixir.Lobby do
  @moduledoc """
  Main lobby for the game
  """
  def print_main_menu do
    """
    1. New game
    2. Continue
    3. Exit
    """
  end
  
  def new_game do
    name = IO.gets("Enter your name: ") |> String.strip
    "You started a new game, #{name} the brave!"
  end

  def continue do
    "Nothing for now"
  end

  def exit do
    IO.puts("Goodbye!")
    System.halt(0)
  end

  def loop do
    IO.puts(TheElixir.Lobby.print_main_menu)
    choice = IO.gets("Which do you pick, adventurer? ")
    choice = Integer.parse(choice) |> elem(0)
    case choice do
      1 -> IO.puts(TheElixir.Lobby.new_game)
      2 -> IO.puts(TheElixir.Lobby.continue)
      3 -> TheElixir.Lobby.exit
      _   -> IO.puts("Try again!")
             TheElixir.Lobby.loop 
    end
  end
end
