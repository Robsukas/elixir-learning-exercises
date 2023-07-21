defmodule WineCellar do
  def explain_colors do
    [white: "Fermented without skin contact.",
     red: "Fermented with skin contact using dark-colored grapes.",
     rose: "Fermented with some skin contact, but not enough to qualify as a red wine."]
  end

  def filter(cellar, color, opts \\ []) do
    colors = Keyword.get_values(opts, :color) |> Enum.uniq()

    filtered_by_color =
      case colors do
        [] -> Enum.filter(cellar, fn {x, _} -> x == color end)
        _ -> Enum.filter(cellar, fn {x, _} -> x in colors end)
      end
    filtered_by_year =
      case Keyword.get(opts, :year) do
        year when is_integer(year) -> Enum.filter(filtered_by_color, fn {_, {_, y, _}} -> y == year end)
        _ -> filtered_by_color
      end
    filtered_by_country =
      case Keyword.get(opts, :country) do
        country when is_binary(country) -> Enum.filter(filtered_by_year, fn {_, {_, _, z}} -> z == country end)
        _ -> filtered_by_year
      end

    Enum.map(filtered_by_country, fn {_, data} -> data end)
  end

  # Already given functions
  defp filter_by_year(wines, year)

  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
