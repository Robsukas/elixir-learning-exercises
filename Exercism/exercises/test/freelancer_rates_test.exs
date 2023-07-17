defmodule FreelancerRatesTest do
  use ExUnit.Case

  test "daily_rate/1 it's the hourly_rate times 8" do
    assert FreelancerRates.daily_rate(50) == 400.0
  end

  test "daily_rate/1 it always returns a float" do
    assert FreelancerRates.daily_rate(60) === 480.0
  end

  test "daily_rate/1 it does not round" do
    assert FreelancerRates.daily_rate(55.1) == 440.8
  end

  # ----------------------------------------------------------------------------

  test "apply_discount/2 a discount of 10% leaves 90% of the original price" do
    assert FreelancerRates.apply_discount(140.0, 10) == 126.0
  end

  test "apply_discount/2 it always returns a float" do
    assert FreelancerRates.apply_discount(100, 10) == 90.0
  end

  test "apply_discount/2 it doesn't round" do
    assert_in_delta FreelancerRates.apply_discount(111.11, 13.5), 96.11015, 1.0e-6
  end

  # ----------------------------------------------------------------------------

  test "monthly_rate/2 it's the daily_rate times 22" do
    assert FreelancerRates.monthly_rate(62, 0.0) == 10912
  end

  test "monthly_rate/2 it always returns an integer" do
    assert FreelancerRates.monthly_rate(70, 0.0) === 12320
  end

  test "monthly_rate/2 the result is rounded up" do
    assert FreelancerRates.monthly_rate(62.8, 0.0) == 11053
    assert FreelancerRates.monthly_rate(65.2, 0.0) == 11476
  end

  test "monthly_rate/2 gives a discount" do
    assert FreelancerRates.monthly_rate(67, 12.0) == 10377
  end

  # ----------------------------------------------------------------------------

  test "days_in_budget/3 it's the budget divided by the daily rate" do
    assert FreelancerRates.days_in_budget(1600, 50, 0.0) == 4
  end

  test "days_in_budget/3 it always returns a float" do
    assert FreelancerRates.days_in_budget(520, 65, 0.0) === 1.0
  end

  test "days_in_budget/3 it rounds down to one decimal place" do
    assert FreelancerRates.days_in_budget(4410, 55, 0.0) == 10.0
    assert FreelancerRates.days_in_budget(4480, 55, 0.0) == 10.1
  end

  test "days_in_budget/3 it applies the discount" do
    assert FreelancerRates.days_in_budget(480, 60, 20) == 1.2
  end
end
