defmodule Lasagna do

  def expected_minutes_in_oven do
    40
  end

  def remaining_minutes_in_oven(minutes) do
    expected_minutes_in_oven() - minutes
  end

  def preparation_time_in_minutes(layer_amount) do
    layer_amount * 2
  end

  def total_time_in_minutes(layer_amount, time_in_oven) do
    preparation_time_in_minutes(layer_amount) + time_in_oven
  end

  def alarm do
    "Ding!"
  end
end
