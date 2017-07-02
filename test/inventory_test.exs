defmodule TheElixirInventoryTest do
  use ExUnit.Case, async: True

  test "adds item" do
    assert TheElixir.Inventory.lookup("head") == :error

    TheElixir.Inventory.add("head", "helm of might")
    assert {:ok, _} = TheElixir.Inventory.lookup("head")
  end

  test "deletes item" do
    TheElixir.Inventory.add("head", "helm of might")
    assert {:ok, _} = TheElixir.Inventory.lookup("head")

    TheElixir.Inventory.delete("head")
    assert TheElixir.Inventory.lookup("head") == :error
  end
end
