defmodule TheElixir.Models.Room do
  @moduledoc """
  A model for the game's rooms
  """

  alias TheElixir.Models.Room, as: Room
  
  defstruct [:name, :max_questions]

  def new(name, max_questions \\ 20) do
    %Room{name: name, max_questions: max_questions}
  end

  def add_question(question) do; end
end
