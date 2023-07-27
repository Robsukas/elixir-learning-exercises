defmodule RPNCalculator do
  def calculate!(stack, operation) do
    case apply(operation, [stack]) do
      :ok -> :ok
      result -> result
    end
  end

  def calculate(stack, operation) do
    try do
      result = apply(operation, [stack])
      {:ok, result}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      result = apply(operation, [stack])
      {:ok, result}
    rescue
      error -> {:error, error.message}
    end
  end
end
