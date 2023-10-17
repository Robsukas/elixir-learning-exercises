defmodule Auction.FakeRepo do
  alias Auction.Item

  @items [
    %Item{
      id: 1,
      title: "Ancient Coin",
      description: "It is estimated to be worth $1,000,000",
      ends_at: ~N[2024-01-01 00:00:00]
      },
    %Item{
      id: 2,
      title: "Poster of Michael Jordan",
      description: "Michael Jordan's rookie poster",
      ends_at: ~N[2025-10-15 13:39:35]
      },
    %Item{
      id: 3,
      title: "Cool Hat",
      description: "It's just a cool hat",
      ends_at: ~N[2025-11-15 13:39:35]
    }
  ]

  def all(Item), do: @items

  def get!(Item, id) do
    Enum.find(@items, fn(item) -> item.id === id end)
  end

  def get_by(Item, map) do
    Enum.find(@items, fn(item) ->
      Enum.all?(Map.keys(map), fn(key) ->
        Map.get(item, key) === map[key]
      end)
    end)
  end
end
