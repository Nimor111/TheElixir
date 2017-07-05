defmodule TheElixir.Logic.Trigger do
  @moduledoc """
  Module that handles triggering of an event in the world.
  Examples being:
  1. When a room is entered
  2. When a quest is stumbled upon
  3. When an answer to a question is given
  4. When tutorials / codex entries are encountered
  """ 
  alias TheElixir.Components.Journal 
  alias TheElixir.Models.Question
  alias TheElixir.Components.World
  alias TheElixir.Models.Task
  
  @doc """
  Add a quest with `quest_name` to the
  player's `journal` on trigger in `room`
  """
  def quest_trigger(room, journal, quest_name) do
    quest = Map.get(room.quests, quest_name)
    Journal.add(journal, quest_name, quest) 
  end
  
  @doc """
  Submits an `answer` to a `question` of a `task`.
  Returns {:ok, task} on succesful answer, :error otherwise
  """
  def answer_trigger(task, question, answer) do
    correct_answer = question.answer
    case answer do
      correct_answer ->
        {:ok, Task.new(task.title,
                       task.description,
                       task.goal - 1,
                       task.questions,
                       task.completed_questions + 1)}
        _ -> {:error, "Wrong answer!"}
    end
  end
  
  @doc """
  Completes a quest with `quest_name` in `room`
  """
  def complete_quest_trigger(room, quest_name) do
    room.complete_quest(room, quest_name)
  end

  @doc """
  Exit room with `room_name`, a.k.a remove it from `world`
  """
  def exit_room_trigger(world, room_name) do
    World.delete(world, room_name)
  end

  @doc """
  Enter room with `room_name`, a.k.a add it to `world`
  """
  def enter_room_trigger(world, room_name, room) do
    World.add(world, room_name, room)
  end
end
