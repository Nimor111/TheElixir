defmodule TheElixir.EctoModels.Player do
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
