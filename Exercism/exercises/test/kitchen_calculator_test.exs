defmodule KitchenCalculatorTest do
  use ExUnit.Case

  test "get volume from tuple pair get cups" do
    assert KitchenCalculator.get_volume({:cup, 1}) == 1
  end

  test "get volume from tuple pair get fluid ounces" do
    assert KitchenCalculator.get_volume({:fluid_ounce, 2}) == 2
  end

  test "get volume from tuple pair get teaspoons" do
    assert KitchenCalculator.get_volume({:teaspoon, 3}) == 3
  end

  test "get volume from tuple pair get tablespoons" do
    assert KitchenCalculator.get_volume({:tablespoon, 4}) == 4
  end

  test "get volume from tuple pair get milliliters" do
    assert KitchenCalculator.get_volume({:milliliter, 5}) == 5
  end

  # ----------------------------------------------------------------------------

  test "convert to milliliters from milliliters" do
    assert KitchenCalculator.to_milliliter({:milliliter, 3}) == {:milliliter, 3}
  end

  test "convert to milliliters from cups" do
    assert KitchenCalculator.to_milliliter({:cup, 3}) == {:milliliter, 720}
  end

  test "convert to milliliters from fluid ounces" do
    assert KitchenCalculator.to_milliliter({:fluid_ounce, 100}) == {:milliliter, 3000}
  end

  test "convert to milliliters from teaspoon" do
    assert KitchenCalculator.to_milliliter({:teaspoon, 3}) == {:milliliter, 15}
  end

  test "convert to milliliters from tablespoon" do
    assert KitchenCalculator.to_milliliter({:tablespoon, 3}) == {:milliliter, 45}
  end

  # ----------------------------------------------------------------------------

  test "convert from milliliters to milliliters" do
    assert KitchenCalculator.from_milliliter({:milliliter, 4}, :milliliter) == {:milliliter, 4}
  end

  test "convert from milliliters to cups" do
    assert KitchenCalculator.from_milliliter({:milliliter, 840}, :cup) == {:cup, 3.5}
  end

  test "convert from milliliters to fluid ounces" do
    assert KitchenCalculator.from_milliliter({:milliliter, 4522.5}, :fluid_ounce) == {:fluid_ounce, 150.75}
  end

  test "convert from milliliters to teaspoon" do
    assert KitchenCalculator.from_milliliter({:milliliter, 61.25}, :teaspoon) == {:teaspoon, 12.25}
  end

  test "convert from milliliters to tablespoon" do
    assert KitchenCalculator.from_milliliter({:milliliter, 71.25}, :tablespoon) == {:tablespoon, 4.75}
  end

  # ----------------------------------------------------------------------------

  test "convert from x to y: teaspoon to tablespoon" do
    assert KitchenCalculator.convert({:teaspoon, 15}, :tablespoon) == {:tablespoon, 5}
  end

  test "convert from x to y: cups to fluid ounces" do
    assert KitchenCalculator.convert({:cup, 4}, :fluid_ounce) == {:fluid_ounce, 32}
  end

  test "convert from x to y: fluid ounces to teaspoons" do
    assert KitchenCalculator.convert({:fluid_ounce, 4}, :teaspoon) == {:teaspoon, 24}
  end

  test "convert from x to y: tablespoons to cups" do
    assert KitchenCalculator.convert({:tablespoon, 320}, :cup) == {:cup, 20}
  end
end
