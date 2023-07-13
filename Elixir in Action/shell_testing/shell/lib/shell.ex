defmodule Shell do
  @pi 3.14159

  # Use the pi attribute to calculate circle area.
  def area(r), do: r * r * @pi

  # Use the pi attribute to calculate circle circumference.
  def circumference(r), do: 2 * r * @pi
end
