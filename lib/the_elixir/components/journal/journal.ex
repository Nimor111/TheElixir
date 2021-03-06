defmodule TheElixir.Components.Journal do
  @moduledoc """
  A place to keep quests in a handy and organized way!
  """

  use GenServer
  
  # Client API
  def start_link(name \\ :journal) do
    GenServer.start_link(__MODULE__, name, name: name)
  end
  
  @doc """
  Lookup a quest with `quest_name` in `journal` if it exists
  Returns `{:ok, quest}` on success, `:error` otherwise
  """
  def lookup(journal, quest_name) do
    case :ets.lookup(journal, quest_name) do
      [{^quest_name, quest}] -> {:ok, quest}
      [] -> :error
    end
  end

  @doc """
  Adds a `quest` with `quest_name` to `journal`
  Returns `quest`, call because of race condition problems
  """
  def add(journal, quest_name, quest) do
    GenServer.call(journal, {:add, quest_name, quest})
  end

  @doc """
  Removes a quest with `quest_name` from `journal`
  """
  def delete(journal, quest_name) do
    GenServer.cast(journal, {:delete, quest_name})
  end

  @doc """
  Get a list of quest names in `journal`
  """
  def get(journal) do
    GenServer.call(journal, {:get, []})
  end

  @doc """
  Stop the journal process
  """
  def stop(journal) do
    GenServer.stop(journal)
  end

  # Server callbacks
  def init(table) do
    journal = :ets.new(table, [:named_table, read_concurrency: true])
    {:ok, journal}
  end
  
  def handle_call({:add, quest_name, quest}, _from, journal) do
    case lookup(journal, quest_name) do
      {:ok, quest} ->
        {:reply, {:ok, quest}, journal}
      :error ->
        :ets.insert(journal, {quest_name, quest})
        {:reply, {:ok, quest}, journal}
    end
  end

  def handle_call({:get, []}, _from, journal) do
    quest_names = :ets.match(journal, {:"$1", :_})
    quest_names = List.flatten(quest_names)
    {:reply, quest_names, journal}
  end

  def handle_cast({:delete, quest_name}, journal) do
    case lookup(journal, quest_name) do
      {:ok, _} ->
        :ets.delete(journal, quest_name)
        {:noreply, journal} 
      :error ->
        {:noreply, journal}
    end
  end
end
