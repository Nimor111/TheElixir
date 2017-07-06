defmodule TheElixir.Logic.RoomGame do
  @moduledoc """
  Module to handle room logic
  """
  
  alias TheElixir.Logic.RoomGame 

  def pick_room(player, room_name) do
    # TODO add progress logic
    player |> RoomGame.enter(room_name)
  end

  def enter(player, room_name) do
    # TODO add different room intros, take from some text file maybe
    IO.puts(
      """
      Welcome to the Introduction! This is the first room that you are going to\n
      encounter, and your great adventure begins here! Each room contains quests that\n
      you need to finish in order to exit, because oh noes! the room was locked the minute\n
      you stepped in! We got you, didn't we? Now, look around and start solving tasks!
      """)
    RoomGame.get_input(player)
  end
end
