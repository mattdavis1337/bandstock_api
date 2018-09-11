defmodule BandstockApiWeb.PageController do
  use BandstockApiWeb, :controller
  alias BandstockApi.Game

  def index(conn, _params) do

    cards = Game.list_cards(); # |> Enum.map(fn(b) -> Repo.preload(b, :cards) end)

    render(conn, "index.html", cards: cards)
  end
end
