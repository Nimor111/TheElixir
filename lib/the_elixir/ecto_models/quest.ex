defmodule TheElixir.EctoModels.Quest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quests" do
    field :name, :string
    field :description, :string
    field :rewards, {:array, :map}
    field :status, :string
    timestamps()
  end

  def changeset(quest, params \\ %{}) do
    quest
    |> cast(params, [:name, :description, :rewards, :status])
  end
end
