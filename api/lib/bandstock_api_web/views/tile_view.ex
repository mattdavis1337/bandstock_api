defmodule BandstockApiWeb.TileView do
  use BandstockApiWeb, :view
  alias BandstockAPI.TileImage
  alias BandstockApiWeb.TileView

  def render("index.json", %{tiles: tiles}) do
    IO.puts("In Render index");
    %{data: render_many(tiles, TileView, "tile.json")}
  end

  def render("show.json", %{tile: tile}) do
    %{data: render_one(tile, TileView, "tile.json")}
  end

  def render("tile.json", %{tile: tile}) do
    file_name = tile.tileimage[:file_name]
    original_url = TileImage.url({file_name, tile}, :original);
    original_url = String.slice(original_url, String.length("/priv/static"), String.length(original_url));
    thumb_url = TileImage.url({file_name, tile}, :thumb);
    thumb_url = String.slice(thumb_url, String.length("/priv/static"), String.length(thumb_url));
    #Map.replace!(tile, "tileimage", TileImage.url({}));
    %{name: tile.name,
      hash: tile.hash,
      image_full: original_url,
      image_thumb: thumb_url}
  end
end
