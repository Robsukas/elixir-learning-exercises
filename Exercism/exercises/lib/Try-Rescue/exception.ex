defmodule RPNCalculator.Exception do

  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
      end
    end
  end

  def divide([divisor, _divided]) when divisor == 0, do: raise DivisionByZeroError

  def divide([divisor, divided]), do: divided / divisor

  def divide(_) do
    raise StackUnderflowError, "when dividing"
  end
end
