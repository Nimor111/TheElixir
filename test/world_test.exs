defmodule TheElixirWorldTest do
  use ExUnit.Case, async: true

  alias TheElixir.Components.World
  alias TheElixir.Models.Room
  alias TheElixir.Models.Quest

  setup context do
    {:ok, _} = World.start_link(context.test)
    room = %Room{name: "Beginning", quests: %{"First quest": %Quest{}}}
    {:ok, world: context.test, room: room}
  end

  test "adds room", %{world: world, room: room} do
    assert World.lookup(world, "First room") == :error

    World.add(world, "First room", room)
    assert {:ok, _} = World.lookup(world, "First room")
  end

  test "deletes room", %{world: world, room: room}  do
    World.add(world, "First room", room)
    assert {:ok, _} = World.lookup(world, "First room")

    World.delete(world, "First room")
    # bogus call so DOWN is processed
    World.add(world, "Second but still first room", room)
    assert World.lookup(world, "First room") == :error
  end

  test "world process is restarted correctly", %{world: world, room: room} do
    World.add(world, "First room", room)

    assert {:ok, _} = World.lookup(world, "First room")

    World.stop(world)
    :timer.sleep(2)
    assert World.lookup(:world, "First room") == :error
  end
end
