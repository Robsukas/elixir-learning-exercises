defmodule Chores.Server do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def add_entry(chores_server, new_entry) do
    GenServer.cast(chores_server, {:add_entry, new_entry})
  end

  def entries(chores_server, date) do
    GenServer.call(chores_server, {:entries, date})
  end

  @impl GenServer
  def init(_) do
    {:ok, Chores.List.new()}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, chores_list) do
    new_state = Chores.List.add_entry(chores_list, new_entry)
    {:noreply, new_state}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, chores_list) do
    {:reply, Chores.List.entries(chores_list, date), chores_list}
  end
end
