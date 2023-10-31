defmodule AuctionWeb.PageController do
  use AuctionWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    items = Auction.list_items()
    render(conn, :home, layout: false, items: items)
  end
end
