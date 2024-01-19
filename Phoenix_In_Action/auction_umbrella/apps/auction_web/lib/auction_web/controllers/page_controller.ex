defmodule AuctionWeb.PageController do
  use AuctionWeb, :controller

  def home(conn, _params) do
    items = Auction.list_items()
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false, items: items)
  end
end
