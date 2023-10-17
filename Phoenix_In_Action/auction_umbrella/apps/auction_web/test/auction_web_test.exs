defmodule AuctionWebTest do
  use ExUnit.Case
  doctest AuctionWeb

  test "greets the world" do
    assert AuctionWeb.hello() == :world
  end
end
