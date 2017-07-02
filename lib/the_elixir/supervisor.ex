defmodule TheElixir.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do 
    children = [
      worker(TheElixir.Inventory, [TheElixir.Inventory]),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
