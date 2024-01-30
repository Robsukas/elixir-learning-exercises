defmodule AuctionWeb.ItemHTML do
  use AuctionWeb, :html

  import Phoenix.HTML.Link
  import Phoenix.HTML.Form

  embed_templates "html/item_html/*"
end
