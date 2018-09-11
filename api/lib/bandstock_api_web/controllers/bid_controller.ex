defmodule BandstockApiWeb.BidController do
  use BandstockApiWeb, :controller

  alias BandstockApi.Game
  alias BandstockApi.Game.Bid

  def index(conn, _params) do
    bids = Game.list_bids()
    render(conn, "index.html", bids: bids)
  end

  def new(conn, _params) do
    changeset = Game.change_bid(%Bid{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bid" => bid_params}) do
    case Game.create_bid(bid_params) do
      {:ok, bid} ->
        conn
        |> put_flash(:info, "Bid created successfully.")
        |> redirect(to: bid_path(conn, :show, bid))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bid = Game.get_bid!(id)
    render(conn, "show.html", bid: bid)
  end

  def edit(conn, %{"id" => id}) do
    bid = Game.get_bid!(id)
    changeset = Game.change_bid(bid)
    render(conn, "edit.html", bid: bid, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bid" => bid_params}) do
    bid = Game.get_bid!(id)

    case Game.update_bid(bid, bid_params) do
      {:ok, bid} ->
        conn
        |> put_flash(:info, "Bid updated successfully.")
        |> redirect(to: bid_path(conn, :show, bid))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bid: bid, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bid = Game.get_bid!(id)
    {:ok, _bid} = Game.delete_bid(bid)

    conn
    |> put_flash(:info, "Bid deleted successfully.")
    |> redirect(to: bid_path(conn, :index))
  end
end
