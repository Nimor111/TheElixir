defmodule TheElixirJournalTest do
  use ExUnit.Case, async: true

  alias TheElixir.Components.Journal
  alias TheElixir.Models.Quest

  setup context do
    {:ok, _} = Journal.start_link(context.test)
    quest = %Quest{name: "Function defs", description: "Examples of function defs"}
    {:ok, journal: context.test, quest: quest}
  end

  test "adds quest", %{journal: journal, quest: quest} do
    assert Journal.lookup(journal, "First quest") == :error

    Journal.add(journal, "First quest", quest)
    assert {:ok, _} = Journal.lookup(journal, "First quest")
  end

  test "deletes quest", %{journal: journal, quest: quest}  do
    Journal.add(journal, "First quest", quest)
    assert {:ok, _} = Journal.lookup(journal, "First quest")

    Journal.delete(journal, "First quest")
    # bogus call so DOWN is processed
    Journal.add(journal, "Second but still first quest", quest)
    assert Journal.lookup(journal, "First quest") == :error
  end

  test "journal process is restarted correctly", %{journal: journal, quest: quest} do
    Journal.add(journal, "First quest", quest)

    assert {:ok, _} = Journal.lookup(journal, "First quest")

    Journal.stop(journal)
    :timer.sleep(2)
    assert Journal.lookup(:journal, "First quest") == :error
  end
end
