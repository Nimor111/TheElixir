defmodule TheElixir.EctoModels.Player do
  @moduledoc """
  Model representing a Player in our game
  """
  
  use Ecto.Schema 
  import Ecto.Changeset

  schema "players" do
    field :name, :string
    field :history, :string
    field :title, :string
    field :progress, :integer
    timestamps()
  end

  def changeset(player, params \\ %{}) do
    player
    |> cast(params, [:name, :history, :title, :progress])
  end
end
