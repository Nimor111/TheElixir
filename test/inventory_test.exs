defmodule TheElixirInventoryTest do
  use ExUnit.Case, async: true

  setup context do
    {:ok, _} = TheElixir.Inventory.start_link(context.test)
    {:ok, inventory: context.test}
  end

  test "adds item", %{inventory: inventory} do
    assert TheElixir.Inventory.lookup(inventory, "head") == :error

    TheElixir.Inventory.add(inventory, "head", "helm of might")
    assert {:ok, _} = TheElixir.Inventory.lookup(inventory, "head")
  end

  test "deletes item", %{inventory: inventory}  do
    TheElixir.Inventory.add(inventory, "head", "helm of might")
    assert {:ok, _} = TheElixir.Inventory.lookup(inventory, "head")

    TheElixir.Inventory.delete(inventory, "head")
    # bogus call so DOWN is processed
    TheElixir.Inventory.add(inventory, "legs", "pants of might")
    assert TheElixir.Inventory.lookup(inventory, "head") == :error
  end

  test "process is restarted correctly", %{inventory: inventory} do
    TheElixir.Inventory.add(inventory, "head", "helm of might")

    assert {:ok, _} = TheElixir.Inventory.lookup(inventory, "head")

    TheElixir.Inventory.stop(inventory)
    :timer.sleep(2) 
    assert TheElixir.Inventory.lookup(inventory, "head") == :error
  end
end
