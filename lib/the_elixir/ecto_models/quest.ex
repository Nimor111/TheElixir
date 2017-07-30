defmodule TheElixir.EctoModels.Quest do
  use Ecto.Schema
  import Ecto.Changeset

  alias TheElixir.EctoModels.Task
  alias TheElixir.EctoModels.Room

  schema "quests" do
    field :name, :string
    field :description, :string
    field :rewards, {:array, :map}
    field :status, :string
    has_many :tasks, Task
    belongs_to :room, Room
    timestamps()
  end

  def changeset(quest, params \\ %{}) do
    quest
    |> cast(params, [:name, :description, :rewards, :status])
  end
end
