defmodule Mix.Tasks.Play do
  use Mix.Task

  alias TheElixir.Lobby

  @doc """
  Run the main game function
  """
  def run(_) do
    Lobby.loop
  end
end
