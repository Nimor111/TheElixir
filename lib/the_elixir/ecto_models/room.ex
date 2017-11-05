defmodule TheElixir.EctoModels.Room do
  @moduledoc """
  Module representing a room/area in the game
  Has quests for solving
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias TheElixir.EctoModels.Quest

  schema "rooms" do
    field :name, :string
    has_many :quests, Quest
    timestamps()
  end

  def changeset(room, params \\ %{}) do
    room
    |> cast(params, [:name, :quests])
  end
end
