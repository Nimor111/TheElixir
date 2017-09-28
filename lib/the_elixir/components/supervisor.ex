defmodule TheElixir.Components.Supervisor do
  @moduledoc false

  use Supervisor

  alias TheElixir.Components.Inventory
  alias TheElixir.Components.World
  alias TheElixir.Components.Journal

  @name :inventory

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do 
    children = [
      worker(Inventory, [@name]),
      worker(Journal, []),
      worker(World, []),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
