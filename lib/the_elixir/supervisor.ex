defmodule TheElixir.Supervisor do
  use Supervisor

  @name :inventory

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do 
    children = [
      worker(TheElixir.Inventory, [@name]),
    ]

    supervise(children, strategy: :one_for_all)
  end
end
