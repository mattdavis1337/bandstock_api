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
    IO.puts("render tile.json");
    file_name = tile.tileimage[:file_name]

    #Map.replace!(tile, "tileimage", TileImage.url({}));
    %{name: tile.name,
      hash: tile.hash,
      image_full: TileImage.url({file_name, tile}, :original),
      image_thumb: TileImage.url({file_name, tile}, :thumb)}
  end
end
