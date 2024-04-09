defmodule AuctionWeb.UserSocket do
  use Phoenix.Socket

  channel "item:*", AuctionWeb.ItemChannel

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
