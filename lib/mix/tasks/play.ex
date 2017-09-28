defmodule Mix.Tasks.Play do
  @moduledoc false

  use Mix.Task

  alias TheElixir.Lobby

  @doc """
  Run the main game function
  """
  def run(_args) do
    Application.ensure_all_started(:the_elixir)
    Lobby.loop
  end
end
