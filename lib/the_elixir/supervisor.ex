defmodule TheElixir.Supervisor do
  @moduledoc false

  use Supervisor
 
  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do 
    children = [
      supervisor(TheElixir.Components.Supervisor, []),
      supervisor(TheElixir.Repo, [])
    ]

    supervise(children, strategy: :one_for_all)
  end
end
