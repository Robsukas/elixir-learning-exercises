defmodule AuctionWeb.ItemHTML do
  use AuctionWeb, :html

  import Phoenix.HTML.Link

  embed_templates "html/item_html/*"
end
