defmodule Mix.Tasks.Play do
  use Mix.Task

  alias TheElixir.Lobby

  @doc """
  Run the main game function
  """
  def run(_) do
    Application.start(:the_elixir)
    Lobby.loop
  end
end
