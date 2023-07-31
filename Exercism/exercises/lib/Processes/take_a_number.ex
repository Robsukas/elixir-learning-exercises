defmodule TakeANumber do
  def start() do
    spawn(fn -> loop(0) end)
  end

  defp loop(state) do
    receive do
      {:report_state, pid} ->
        send(pid, state)
        loop(state)

      {:take_a_number, pid} ->
        send(pid, state + 1)
        loop(state + 1)

      {:stop, pid} ->
        :ok

      _ -> loop(state)
    end
  end
end
