defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100.00)

    for x <- tops, y <- bottoms, different_color?(x, y), within_budget?(x, y, max_price) do
      {x, y}
    end
  end

  defp different_color?(top, bottom), do: top.base_color != bottom.base_color

  defp within_budget?(top, bottom, max_price), do: top.price + bottom.price < max_price
end
