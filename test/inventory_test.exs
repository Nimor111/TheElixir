defmodule TheElixirInventoryTest do
  use ExUnit.Case, async: True

  setup do
    {:ok, inventory} = TheElixir.Inventory.start_link
    {:ok, inventory: inventory}
  end

  test "adds item", %{inventory: _} do
    assert TheElixir.Inventory.lookup("head") == :error

    TheElixir.Inventory.add("head", "helm of might")
    assert {:ok, _} = TheElixir.Inventory.lookup("head")
  end

  test "deletes item", %{inventory: _} do
    TheElixir.Inventory.add("head", "helm of might")
    assert {:ok, _} = TheElixir.Inventory.lookup("head")

    TheElixir.Inventory.delete("head")
    assert TheElixir.Inventory.lookup("head") == :error
  end
end
