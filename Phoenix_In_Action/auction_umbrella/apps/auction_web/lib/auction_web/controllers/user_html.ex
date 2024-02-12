defmodule AuctionWeb.UserHTML do
  use AuctionWeb, :html

  import Phoenix.HTML.Form

  embed_templates "html/user_html/*"
end
