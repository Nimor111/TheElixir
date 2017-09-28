defmodule TheElixir.Components.Inventory do
  @moduledoc """
  The player's inventory - stores items in the form {body part => name}
  """
  use GenServer

  # Client API
  
  @doc """
  Starts the process
  """
  def start_link(name \\ :inventory) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  @doc """
  Lookup an item at `position` in inventory 
  Returns `{:ok, item}` on success, `:error` otherwise
  """
  def lookup(server, position) do
    case :ets.lookup(server, position) do
      [{^position, item}] -> {:ok, item}
      [] -> :error
    end
  end 

  @doc """
  Add an `item` at `position` to the inventory
  """
  def add(server, position, item) do
    GenServer.call(server, {:add, position, item})
  end

  @doc """
  Remove item at `position` in inventory
  """
  def delete(server, position) do
    GenServer.cast(server, {:delete, position})
  end

  @doc """
  Retrieves the entire `inventory`
  """
  def get(server) do
    GenServer.call(server, {:get, []})
  end

  @doc """
  Stop the inventory process
  """
  def stop(server) do
    GenServer.stop(server)
  end

  # Server callbacks
  def init(table) do
    inventory = :ets.new(table, [:named_table, read_concurrency: true])
    {:ok, inventory}
  end

  def handle_call({:get, []}, _from, inventory) do
    items = :ets.match(inventory, {:"$1", :"$2"})
    {:reply, items, inventory}
  end

  def handle_call({:add, position, item}, _from, inventory) do
    case lookup(inventory, position) do
      {:ok, pid} ->
        {:reply, {:ok, pid} , inventory}
      :error ->
        :ets.insert(inventory, {position, item})
        {:reply, {:ok, item}, inventory}
    end
  end

  def handle_cast({:delete, position}, inventory) do
    case lookup(inventory, position) do
      {:ok, _} ->
        :ets.delete(inventory, position)
        {:noreply, inventory}
      :error ->
        {:noreply, inventory}
    end
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
