defmodule TheElixirInventoryTest do
  use ExUnit.Case, async: true

  alias TheElixir.Components.Inventory

  setup context do
    {:ok, _} = Inventory.start_link(context.test)
    {:ok, inventory: context.test}
  end

  test "adds item", %{inventory: inventory} do
    assert Inventory.lookup(inventory, "head") == :error

    Inventory.add(inventory, "head", "helm of might")
    assert {:ok, _} = Inventory.lookup(inventory, "head")
  end

  test "deletes item", %{inventory: inventory}  do
    Inventory.add(inventory, "head", "helm of might")
    assert {:ok, _} = Inventory.lookup(inventory, "head")

    Inventory.delete(inventory, "head")
    # bogus call so DOWN is processed
    Inventory.add(inventory, "legs", "pants of might")
    assert Inventory.lookup(inventory, "head") == :error
  end

  test "process is restarted correctly", %{inventory: inventory} do
    Inventory.add(inventory, "head", "helm of might")

    assert {:ok, _} = Inventory.lookup(inventory, "head")

    Inventory.stop(inventory)
    :timer.sleep(2)
    # restarted with default value, not so good
    assert Inventory.lookup(:inventory, "head") == :error
  end
end
