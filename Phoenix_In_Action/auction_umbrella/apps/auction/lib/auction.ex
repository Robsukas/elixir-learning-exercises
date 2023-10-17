defmodule Auction.Item do
  defstruct [:id, :title, :description, :ends_at]
end


defmodule Auction do
  alias Auction.{FakeRepo, Item}

  @repo FakeRepo

  def list_items do
    @repo.all(Item)
  end

  def get_item!(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end
end


defmodule Auction.FakeRepo do
  alias Auction.Item

  @items [
    %Item{id: 1,
          title: "Ancient Coin",
          description: "It is estimated to be worth $1,000,000",
          ends_at: ~N[2024-01-01 00:00:00]
          },
    %Item{id: 2,
          title: "Poster of Michael Jordan",
          description: "Michael Jordan's rookie poster",
          ends_at: ~N[2025-10-15 13:39:35]
          },
    %Item{id: 3,
          title: "Cool Hat",
          description: "It's just a cool hat",
          ends_at: ~N[2025-11-15 13:39:35]
          }
  ]

  def all(Item) do
    @items
  end

  def get!(Item, id) do
    Enum.find(@items, fn item -> item.id == id end)
  end

  def get_by(Item, attrs) do
    Enum.find(@items, fn item ->
      Enum.all?(Map.keys(attrs), fn(key) ->
        Map.get(item, key) === attrs[key]
      end)
    end)
  end
end
