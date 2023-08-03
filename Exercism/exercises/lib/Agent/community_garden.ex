# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  use Agent

  def start(opts \\ []) do
    Agent.start_link(fn -> %{plots: [], id_counter: 0} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn %{plots: plots} -> plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: plots, id_counter: id_counter} ->
      id_counter = id_counter + 1
      plot = %Plot{plot_id: id_counter, registered_to: register_to}
      {plot, %{plots: [plot| plots], id_counter: id_counter}}
    end)
  end

  def release(pid, plot_id) do
    Agent.cast(pid, fn %{plots: plots} = state ->
      plots = Enum.filter(plots, fn %{plot_id: p} -> p != plot_id end)
      %{state | plots: plots}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} -> plots end)
    |> Enum.find(&(&1.plot_id == plot_id))
    |> case do
      nil -> {:not_found, "plot is unregistered"}
      plot -> plot
    end
  end
end
