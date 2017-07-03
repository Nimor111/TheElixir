defmodule TheElixir.Components.World do
  @moduledoc """
  The world the adventure is going to be happening in!
  """ 

  use GenServer

  # Client API
  
  @doc """
  Start the world process
  """
  def start_link(name \\ :world) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  @doc """
  Add a `room` to the `world`
  """
  def add(world, room_name, room) do
    GenServer.call(world, {:add, room_name, room})
  end

  @doc """
  Removes a room with `room_name` from the `world`
  """
  def delete(world, room_name) do
    GenServer.cast(world, {:delete, room_name})
  end

  @doc """
  Lookup a room with `room_name` in `world`
  Return `{:ok, room}` on success, `:error` otherwise 
  """
  def lookup(world, room_name) do
    case :ets.lookup(world, room_name) do
      [{^room_name, room}] -> {:ok, room}
      [] -> :error
    end
  end

  @doc """
  Retrieve all room_names in `world`
  """
  def get(world) do
    GenServer.call(world, {:get, []})
  end

  # Server callbacks
  
  def init(table) do
    world = :ets.new(table, [:named_table, read_concurrency: true])
    {:ok, world}
  end

  def handle_call({:add, room_name, room}, _from, world) do
    case lookup(world, room_name) do
      {:ok, room} ->
        {:reply, {:ok, room}, world}
      :error ->
        :ets.insert(world, {room_name, room})
        {:reply, {:ok, room}, world}
    end
  end

  def handle_call({:get, []}, _from, world) do
    room_names = :ets.match(world, {:"$1", :_})
                 |> List.flatten
    {:reply, room_names, world}
  end

  def handle_cast({:delete, room_name}, world) do
    case lookup(world, room_name) do
      {:ok, _} ->
        :ets.delete(world, room_name)
        {:noreply, world}
      :error ->
        {:noreply, world}
    end
  end
end
