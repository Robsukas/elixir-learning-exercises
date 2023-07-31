defmodule ExceptionTest do
  use ExUnit.Case

  test "DivisionByZeroError fields defined by `defexception`" do
    assert %RPNCalculator.Exception.DivisionByZeroError{}.__exception__ == true

    assert %RPNCalculator.Exception.DivisionByZeroError{}.__struct__ ==
             RPNCalculator.Exception.DivisionByZeroError

    assert %RPNCalculator.Exception.DivisionByZeroError{}.message == "division by zero occurred"
  end

  test "DivisionByZeroError message when raised with raise/1" do
    assert_raise RPNCalculator.Exception.DivisionByZeroError,
             "division by zero occurred",
             fn -> raise RPNCalculator.Exception.DivisionByZeroError end
  end

  # ----------------------------------------------------------------------------

  test "StackUnderflowError fields defined by `defexception`" do
    assert %RPNCalculator.Exception.StackUnderflowError{}.__exception__ == true

    assert %RPNCalculator.Exception.StackUnderflowError{}.__struct__ ==
             RPNCalculator.Exception.StackUnderflowError

    assert %RPNCalculator.Exception.StackUnderflowError{}.message == "stack underflow occurred"
  end

  test "StackUnderflowError message when raised with raise/1" do
    assert_raise RPNCalculator.Exception.StackUnderflowError,
             "stack underflow occurred",
             fn -> raise RPNCalculator.Exception.StackUnderflowError end
  end

  test "StackUnderflowError message when raised with raise/2" do
    assert_raise RPNCalculator.Exception.StackUnderflowError,
             "stack underflow occurred, context: test",
             fn -> raise RPNCalculator.Exception.StackUnderflowError, "test" end
  end

  # ----------------------------------------------------------------------------

  test "divide/1 when stack doesn't contain any numbers, raise StackUnderflowError" do
    assert_raise RPNCalculator.Exception.StackUnderflowError,
             "stack underflow occurred, context: when dividing",
             fn -> RPNCalculator.Exception.divide([]) end
  end

  test "divide/1 when stack contains only one number, raise StackUnderflowError" do
    assert_raise RPNCalculator.Exception.StackUnderflowError,
             "stack underflow occurred, context: when dividing",
             fn -> RPNCalculator.Exception.divide([3]) end
  end

  test "divide/1 when stack contains only one number, raise StackUnderflowError, even when it's a zero" do
    assert_raise RPNCalculator.Exception.StackUnderflowError,
             "stack underflow occurred, context: when dividing",
             fn -> RPNCalculator.Exception.divide([0]) end
  end

  test "divide/1 when divisor is 0, raise DivisionByZeroError" do
    assert_raise RPNCalculator.Exception.DivisionByZeroError, "division by zero occurred", fn ->
      RPNCalculator.Exception.divide([0, 2])
    end
  end

  test "divide/1 divisor is not 0, don't raise" do
    assert RPNCalculator.Exception.divide([2, 4]) == 2
  end
end
