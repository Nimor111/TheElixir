defmodule TheElixir.Components.World do
  @moduledoc """
  The world the adventure is going to be happening in!
  """ 

  use GenServer

  def start_link(name \\ :world) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def init(table) do
    world = :ets.new(table, [:named_table, read_concurrency: true])
    {:ok, world}
  end
end
