defmodule TheElixir.Components.Journal do
  @moduledoc """
  A place to keep quests in a handy and organized way!
  """

  use GenServer

  def start_link(name \\ :journal) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def init(table) do
    journal = :ets.new(table, [:named_table, read_concurrency: true])
    {:ok, journal}
  end
end
