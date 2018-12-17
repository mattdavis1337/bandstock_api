defmodule BandstockApiWeb.TileController do
  use BandstockApiWeb, :controller

  alias BandstockApi.Game
  alias BandstockApi.Game.Tile
  alias BandstockApi.Game.Board

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
    IO.inspect("in tile_controller.create")
    board = Game.get_board!(1) #MFD TODO: put everything on board 1 until we're ready to get fancy

    with  {:ok, tileimage} <- get_tileimage(tile_params),
          {:ok, filename} <- parse_filename(tileimage),
          #{:ok, name} <- parse_file_extension(filename),
          {:ok, tile_params} <- parse_tile_params(tile_params, tileimage),
          {:ok, %Tile{} = tile} <- Game.create_tile(tile_params),
          {:ok, %Board{} = board} <- Game.link_tile_and_board(tile, board)
    do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tile_path(conn, :show, tile))
      |> render("show.json", tile: tile)
    else
      :error -> :error
    end
  end

  def get_tileimage(%{"tileimage" => nil}), do: {:error}
  def get_tileimage(%{"tileimage" => tileimage}), do: {:ok, tileimage}
  def get_tileimage(_), do: {:error}

  defp parse_filename(tileimage) do
    IO.puts("parse_filename")
    IO.inspect(tileimage)
    Map.fetch(tileimage, :filename)
  end

  defp parse_file_extension(filename) do
    IO.puts("parse_file_extension")
    IO.inspect(filename)
    {:ok, Path.extname(filename) |> String.downcase}
  end

  defp parse_tile_params(params, tileimage) do
    IO.puts("parse_tile_params")

    a = Map.replace!(params, "hash", String.upcase(random_string(16)))
    b = Map.replace!(a, "tileimage", Map.replace!(tileimage, :filename, a["hash"] <> ".png"))
    {:ok, b}
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.encode16 |> binary_part(0, length);
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
