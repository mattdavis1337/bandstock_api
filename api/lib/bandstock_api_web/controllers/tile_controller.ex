defmodule BandstockApiWeb.TileController do
  use BandstockApiWeb, :controller

  alias BandstockApi.Game
  alias BandstockApi.Game.Tile

  action_fallback BandstockApiWeb.FallbackController

  def index(conn, _params) do
    tiles = Game.list_tiles()
    render(conn, "index.json", tiles: tiles)
  end

  def new(conn, _params) do
    changeset = Game.change_tile(%Tile{})
    render(conn, "new.html", changeset: changeset)
  end


  def create(conn, %{"tile" => tile_params}) do
    IO.puts("In tile_controller create with:");
    IO.inspect(tile_params);
    with {:ok, %Tile{} = tile} <- Game.create_tile(tile_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tile_path(conn, :show, tile))
      |> render("show.json", tile: tile)
    end
  end

  def show(conn, %{"id" => id}) do
    tile = Game.get_tile!(id)
    render(conn, "show.json", tile: tile)
  end

  def update(conn, %{"id" => id, "tile" => tile_params}) do
    tile = Game.get_tile!(id)

    with {:ok, %Tile{} = tile} <- Game.update_tile(tile, tile_params) do
      render(conn, "show.json", tile: tile)
    end
  end

  def delete(conn, %{"id" => id}) do
    tile = Game.get_tile!(id)
    with {:ok, %Tile{}} <- Game.delete_tile(tile) do
      send_resp(conn, :no_content, "")
    end
  end
end
