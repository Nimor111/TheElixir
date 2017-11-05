defmodule TheElixir.Logic.RoomGame do
  @moduledoc """
  Module to handle room logic
  """
  
  alias TheElixir.Logic.RoomGame 
  alias TheElixir.Components.World
  alias TheElixir.Components.Journal
  alias TheElixir.Components.Inventory
  alias TheElixir.Logic.Trigger
  alias TheElixir.Models.Room
  alias TheElixir.Models.Quest
  alias TheElixir.Models.Task
  alias TheElixir.Models.Question
  alias TheElixir.Logic.Game
  alias TheElixir.Lobby

  @doc """
  Pick a room to enter, according to player progress
  Note, this is a TODO feature, for now it picks the only room
  """
  def pick_room(player, room_name) do
    # TODO add progress logic
    player |> RoomGame.enter(room_name)
  end

  @doc """
  Text that appears on entering the room, another TODO is 
  add different intros for different rooms
  """
  def enter(player, room_name) do
    # TODO add different room intros, take from some text file maybe
    IO.puts(
      """
      Welcome to the #{room_name} room! This is the first room that you are going to
      encounter, and your great adventure begins here! Each room contains quests that
      you need to finish in order to exit, because oh noes! the room was locked the minute
      you stepped in! We got you, didn't we? Now, look around and start solving tasks!
      """)
    {:ok, room} = World.lookup(:world, room_name)
    player |> RoomGame.get_input(room)
  end

  @doc """
  All commands the `player` can execute in the `room`
  On key press `h`
  """
  def command_help(player, room) do
    IO.puts([
      "e -> exit / quit\n",
      "inv -> view inventory\n",
      "q -> view quests in the room\n",
      "add -> add a quest to your journal\n",
      "j -> view journal\n",
      "c -> clear screen\n",
      "s -> start solving quest\n",
      "Here's a tip - add a quest to the journal before starting to solve it!\n"
    ])
    player |> RoomGame.get_input(room)
  end

  @doc """
  Same as get journal in Game, TODO refactor, be DRY
  """
  def get_journal(player, room) do
    quests = Journal.get(:journal)
    case quests do
      [] -> IO.puts("No entries yet.")
      _  -> IO.puts(quests)
    end
    player |> RoomGame.get_input(room)
  end

  @doc """
  Same as get input in Game, get player input, send it to match
  """
  def get_input(player, room) do
    input = IO.gets("(press h for help) >> ") |> String.strip
    player |> RoomGame.match_input(input, room)
  end

  @doc """
  Clear the screen
  On key press `c`
  """
  def clear_screen(player, room) do
    IO.puts("Clearing screen...")
    Process.sleep(1000)
    System.cmd "clear", [], into: IO.stream(:stdio, :line)
    player |> RoomGame.get_input(room)
  end
  
  @doc """
  Get inventory of `player`
  On key press `inv`
  """
  def get_inventory(player, room) do
    items = Inventory.get(:inventory)
    case items do
      [] -> IO.puts("No items yet.")
      _  -> IO.puts(items)
    end
    player |> RoomGame.get_input(room)
  end

  @doc """
  Get input of player and match it with correct function or try again
  """
  def match_input(player, input, room) do
    case input do
      "q" -> 
        player |> RoomGame.show_quests(room)
      "add" ->
        player |> RoomGame.add_quest(room)
      "j" ->
        player |> RoomGame.get_journal(room)
      "h" ->
        player |> RoomGame.command_help(room)
      "e" ->
        player |> RoomGame.exit(room)
      "c" ->
        player |> RoomGame.clear_screen(room) 
      "inv" ->
        player |> RoomGame.get_inventory(room)
      "s" ->
        player |> RoomGame.choose_quest(room)
      _ ->
        IO.puts "We don't know this command ( yet ). Read the prompt!"
        player |> RoomGame.get_input(room)
    end 
  end

  @doc """
  Show the quests in the room, akin to looking around it
  """
  def show_quests(player, room) do
    Enum.each room.quests, fn {_, v} -> IO.puts "#{v}" end
    player |> RoomGame.get_input(room)
  end

  @doc """
  Start a quest, akin to picking it up and starting it
  """
  def add_quest(player, room) do
    quest_name = IO.gets("(Which quest would you like to begin?) >> ") |> String.strip
    case Map.fetch(room.quests, quest_name) do
      {:ok, quest} ->
        Journal.add(:journal, quest_name, quest)
        IO.puts("Quest added to journal!")
        player |> RoomGame.get_input(room)
      :error ->
        IO.puts "No such quest in this room!"
        player |> RoomGame.add_quest(room)
    end
  end

  @doc """
  Checks if `player` can exit `room`
  If there are no more quests to complete, returns to hallway
  If not, returns to room prompt
  """
  def exit(player, room) do
    case Room.exit?(room) do 
      true ->
        IO.puts("The way is clear. Returning to hall...")
        Game.hallway_introduction(player)
      _    ->
        IO.puts("Can't exit yet, complete all quests!")
        player |> RoomGame.get_input(room)
    end
  end

  @doc """
  Start solving a `quest`
  """
  def solve(player, room, quest) do
    IO.puts("You started solving #{quest.name}")
    case Quest.completed?(quest) do
      true -> IO.puts("Quest done!")
        quest_name = quest.name
        room = room |> Room.complete_quest(quest_name)
        player |> RoomGame.get_input(room)
      false  -> 
        tasks = quest.tasks
        [ task | tasks ] = tasks
        player |> RoomGame.solve_task(room, quest, task)
    end
  end

  @doc """
  Gets an answer to `question` of `task`
  and checks it with the trigger
  """
  def check_answer(player, room, quest, task, question) do
    Question.show(question)
    answer = IO.gets("(And the answer is...) >> ") |> String.strip
    result = task |> Trigger.answer_trigger(question, answer)
    case result do
      {:ok, task} ->
        IO.puts("Correct answer!")
        tasks = quest.tasks
        [ _ | tasks ] = tasks
        quest = Quest.new(quest.name, quest.description, quest.rewards, tasks)
        player |> RoomGame.solve_task(room, quest, task)
      {:error, _} ->
        IO.puts("Incorrect!")
        player |> RoomGame.check_answer(room, quest, task, question)
    end
  end

  @doc """
  Choose a quest from the journal to complete
  """
  def choose_quest(player, room) do
    input = IO.gets("Choose a quest to complete: ( or view journal ) >> ") |> String.strip
    case input do
      "j" -> IO.puts(Journal.get(:journal))
        player |> RoomGame.choose_quest(room)
      _   -> player |> RoomGame.handle_choose_quest(room, input)
    end
  end

  @doc """
  Helper function for `choose_quest`
  """
  def handle_choose_quest(player, room, quest_name) do
    case Journal.lookup(:journal, quest_name) do
      {:ok, quest} ->
        player |> RoomGame.solve(room, quest)
      :error ->
        IO.puts "Quest doesn't exist"
        player |> RoomGame.choose_quest(room)
    end
  end

  @doc """
  Solve a `task`
  """
  def solve_task(player, room, quest, task) do
    case Task.completed?(task) do
      true ->
        IO.puts("You solved the task!")
        player |> RoomGame.solve(room, quest)
      false ->
        questions = task.questions
        [ question | questions ] = questions
        player |> RoomGame.check_answer(room, quest, task, question)
        player |> RoomGame.solve_task(room, quest, task)
    end
  end
end
