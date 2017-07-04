defmodule TheElixirTriggerTest do
  use ExUnit.Case

  alias TheElixir.Models.Quest
  alias TheElixir.Models.Room
  alias TheElixir.Components.Journal
  alias TheElixir.Models.Task
  alias TheElixir.Models.Question
  alias TheElixir.Components.World
  alias TheElixir.Logic.Trigger

  setup context do
    {:ok, _} = Journal.start_link(context.test)  
    task = Task.new("Test task", "A test description!", 3)
    quest = Quest.new("Test quest", "A test quest!",
                      ["recursion"], [task])
    room = Room.new("Test room", %{"First quest" => quest})
    {:ok, journal: context.test, task: task, quest: quest, room: room}
  end

  test "adds quest to journal", state do
    Trigger.quest_trigger(state[:room], state[:journal], "First quest")
    assert {:ok, _} = Journal.lookup(state[:journal], "First quest")
  end
end
