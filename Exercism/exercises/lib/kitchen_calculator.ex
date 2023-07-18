defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_type, volume} = volume_pair
    volume
  end

  def to_milliliter(volume_pair) do
    volume = get_volume(volume_pair)
    {type, _volume} = volume_pair
    converted_volume = cond do
      type == :cup -> 240 * volume
      type == :fluid_ounce -> 30 * volume
      type == :teaspoon -> 5 * volume
      type == :tablespoon -> 15 * volume
      true -> volume
    end
    {:milliliter, converted_volume}
  end

  def from_milliliter(volume_pair, unit) do
    volume = get_volume(volume_pair)
    converted_volume = cond do
      unit == :cup -> volume / 240
      unit == :fluid_ounce -> volume / 30
      unit == :teaspoon -> volume / 5
      unit == :tablespoon -> volume / 15
      true -> volume
    end
    {unit, converted_volume}
  end

  def convert(volume_pair, unit) do
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
