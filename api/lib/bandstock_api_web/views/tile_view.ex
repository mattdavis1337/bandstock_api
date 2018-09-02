defmodule BandstockApiWeb.TileView do
  use BandstockApiWeb, :view
  alias BandstockAPI.TileImage
  alias BandstockApiWeb.TileView

  def render("index.json", %{tiles: tiles}) do
    %{data: render_many(tiles, TileView, "tile.json")}
  end

  def render("show.json", %{tile: tile}) do
    %{data: render_one(tile, TileView, "tile.json")}
  end

  def render("tile.json", %{tile: tile}) do
    %{id: tile.id,
      name: tile.name,
      hash: tile.hash,
      tileimage: tile.tileimage}
  end
end
