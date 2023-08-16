defmodule Chores.Cache do
  use GenServer

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:server_process, chores_list_name}, _, chores_servers) do
    case Map.fetch(chores_servers, chores_list_name) do
      {:ok, chore_server} ->
        {:reply, chore_server, chores_servers}
      :error ->
        {:ok, new_server} = Chores.Server.start()

        {:reply, new_server, Map.put(chores_servers, chores_list_name, new_server)}
    end
  end

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def server_process(cache_pid, chores_list_name) do
    GenServer.call(cache_pid, {:server_process, chores_list_name})
  end
end
