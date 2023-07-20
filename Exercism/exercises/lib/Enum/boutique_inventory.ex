defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price), :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn x -> x[:price] == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory,
    fn item ->
      updated_name =
        case String.contains?(item.name, old_word) do
          true -> String.replace(item.name, old_word, new_word)
          false -> item.name
        end
      %{item | name: updated_name}
    end
    )
  end

  def increase_quantity(item, increase_amount) do
    sizes = item[:quantity_by_size]
    updated_sizes = Enum.into(sizes, %{}, fn {size, quantity} -> {size, quantity + increase_amount} end)
    %{item | quantity_by_size: updated_sizes}
  end

  def total_quantity(item) do
    sizes = item[:quantity_by_size]
    Enum.reduce(Map.values(sizes), 0, &+/2 end)
  end
end
