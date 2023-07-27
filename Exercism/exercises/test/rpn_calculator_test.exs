defmodule RPNCalculatorTest do
  use ExUnit.Case

  test "calculate! returns what the operation does: :ok atom" do
    assert RPNCalculator.calculate!([], fn _ -> :ok end) == :ok
  end

  test "calculate! returns what the operation does: an ok string" do
    assert RPNCalculator.calculate!([], fn _ -> "ok" end) == "ok"
  end

  test "let it crash" do
    assert_raise RuntimeError, fn -> RPNCalculator.calculate!([], fn _ -> raise "test error" end) end
  end



  test "calculate returns the result of the operation (a string) wrapped in an :ok tuple" do
    assert RPNCalculator.calculate([], fn _ -> "operation completed" end) ==
      {:ok, "operation completed"}
  end

  test "calculate returns the result of the operation (an atom) wrapped in an :ok tuple" do
    assert RPNCalculator.calculate([], fn _ -> :success end) == {:ok, :success}
  end

  test "rescue the crash, no message" do
    assert RPNCalculator.calculate([], fn _ -> raise "test error" end) == :error
  end



  test "calculate_verbose returns the result of the operation (a string) wrapped in an :ok tuple" do
    assert RPNCalculator.calculate_verbose([], fn _ -> "operation completed" end) ==
      {:ok, "operation completed"}
  end

  test "calculate_verbose returns the result of the operation (an atom) wrapped in an :ok tuple" do
    assert RPNCalculator.calculate_verbose([], fn _ -> :success end) == {:ok, :success}
  end

  test "rescue the crash, get error tuple with message" do
    assert RPNCalculator.calculate_verbose([], fn _ -> raise ArgumentError, "test error" end) ==
      {:error, "test error"}
  end
end
