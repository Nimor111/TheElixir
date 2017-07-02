defmodule SupervisorTest do
  use ExUnit.Case
  
  test "process is restarted correctly" do
    TheElixir.Inventory.add("head", "helm of might")

    assert {:ok, item} = TheElixir.Inventory.lookup("head")

    ref = Process

       
  end
end
