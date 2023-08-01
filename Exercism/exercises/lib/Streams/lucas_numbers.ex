defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count) when count >= 1 and is_integer(count) do
    Stream.iterate({2, 1}, fn {a, b} -> {b, a + b} end)
    |> Stream.map(&elem(&1, 0))
    |> Enum.take(count)
  end

  def generate(_)do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end
end
