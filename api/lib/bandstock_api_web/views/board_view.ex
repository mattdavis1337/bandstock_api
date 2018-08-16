defmodule BandstockApiWeb.BoardView do
  use BandstockApiWeb, :view
  alias BandstockApiWeb.BoardView

  def render("index.json", %{boards: boards}) do
    %{data: render_many(boards, BoardView, "board.json")}
  end

  def render("show.json", %{board: board}) do
    %{data: render_one(board, BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    %{id: board.id,
      name: board.name,
      hash: board.hash}
  end
end
