defmodule TheElixir.Supervisor do
  use Supervisor
 
  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do 
    children = [
      supervisor(TheElixir.Components.Supervisor, []),
    ]

    supervise(children, strategy: :one_for_all)
  end
end
