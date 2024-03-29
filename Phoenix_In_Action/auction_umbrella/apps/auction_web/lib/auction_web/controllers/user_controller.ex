defmodule AuctionWeb.UserController do
  use AuctionWeb, :controller
  plug :prevent_unauthorized_access when action in [:show]

  def show(conn, %{"id" => id}) do
    user = Auction.get_user(id)
    bids = Auction.get_bids_for_user(user)
    render(conn, "show.html", user: user, bids: bids)
  end

  def new(conn, _params) do
    user = Auction.new_user()
    render(conn, "new.html", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    case Auction.insert_user(user_params) do
      {:ok, user} -> redirect(conn, to: AuctionWeb.Router.Helpers.user_path(conn, :show, user))
      {:error, user} -> render(conn, "new.html", user: user)
    end
  end

  defp prevent_unauthorized_access(conn, _opts) do
    current_user = Map.get(conn.assigns, :current_user)

    requested_user_id =
      conn.params
      |> Map.get("id")
      |> String.to_integer()

    if current_user == nil || current_user.id != requested_user_id do
      conn
      |> put_flash(:error, "Nice try, friend. That's not a page for you.")
      |> redirect(to: AuctionWeb.Router.Helpers.item_path(conn, :index))
      |> halt()
    else
      conn
    end
  end
end
