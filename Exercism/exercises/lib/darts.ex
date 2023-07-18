defmodule Darts do

  def score({x, y}) do
    distance = :math.sqrt(x**2 + y**2)
    cond do
      distance <= 10 && distance > 5 -> 1
      distance <= 5 && distance > 1 -> 5
      distance <= 1 && distance >= 0 -> 10
      true -> 0
    end
  end
end
