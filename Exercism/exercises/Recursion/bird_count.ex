defmodule BirdCount do
  def today(list) do
    case list do
      [head | _] -> head
      _ -> nil
    end
  end

  def increment_day_count(list) do
    case list do
      [] -> [1]
      [head | tail] when is_integer(head) -> [head + 1 | tail]
    end
  end

  def has_day_without_birds?(list) do
    do_has_day_without_birds?(false, list)
  end

  defp do_has_day_without_birds?(check, []) do
    check
  end

  defp do_has_day_without_birds?(check, [head | tail]) do
    new_check =
      if head == 0 do
        true
      else
        check
      end
    do_has_day_without_birds?(new_check, tail)
  end

  def total(list) do
    do_total(0, list)
  end

  defp do_total(current_total, []) do
    current_total
  end

  defp do_total(current_total, [head | tail]) do
    new_total = head + current_total
    do_total(new_total, tail)
  end

  def busy_days(list) do
    do_busy_days(0, list)
  end

  defp do_busy_days(current_amount, []) do
    current_amount
  end

  defp do_busy_days(current_amount, [head | tail]) do
    new_amount =
      if head >= 5 do
        current_amount + 1
      else
        current_amount
      end
    do_busy_days(new_amount, tail)
  end
end
