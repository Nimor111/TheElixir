defmodule TheElixir.Inventory do
  use GenServer

  # Client API
  
  @doc """
  Start the inventory bag with given `name`
  """ 
  def start_link do
    GenServer.start_link(__MODULE__, [], name: :inventory)
  end 

  @doc """
  Lookup an item at `position` in inventory

  Returns `{:ok, item}` on success, `:error` otherwise
  """ 
  def lookup(position) do
    GenServer.call(:inventory, {:lookup, position})
  end 

  @doc """
  Add an `item` at `position` to the inventory
  """
  def add(position, item) do
    GenServer.cast(:inventory, {:add, position, item})
  end

  @doc """
  Remove item at `position` in inventory
  """
  def delete(position) do
    GenServer.cast(:inventory, {:delete, position})
  end

  @doc """
  Retrieves the entire inventory
  """
  def get do
    GenServer.call(:inventory, {:get, []})
  end

  # Server callbacks
  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:lookup, position}, _from, inventory) do
    case Map.fetch(inventory, position) do
      {:ok, item} -> {:reply, {:ok, item}, inventory}
      :error      -> {:reply, :error, inventory}
    end
  end

  def handle_call({:get, []}, _from, inventory) do
    {:reply, inventory, inventory}
  end

  def handle_cast({:add, position, item}, inventory) do
    {:noreply, Map.put(inventory, position, item)} 
  end

  def handle_cast({:delete, position}, inventory) do
    {:noreply, Map.delete(inventory, position)}
  end
end
