defmodule TheElixir.Inventory.Supervisor do
  use Supervisor
  
  # A module attr to hold the name of the supervisor
  @name TheElixir.Inventory.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def start_inventory do
    Supervisor.start_child(@name, [])
  end

  def init(:ok) do
    children = [
      worker(TheElixir.Inventory, []),
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
