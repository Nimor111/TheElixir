defmodule TheElixir.Application do
 @moduledoc false

  use Application

  def start(_type, _args) do
    TheElixir.Supervisor.start_link
  end
end
