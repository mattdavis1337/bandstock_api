defmodule BandstockApi.Game do
  @moduledoc """
  The Game context.
  """

  import Ecto.Query, warn: false
  alias BandstockApi.Repo

  alias BandstockApi.Game.Tile
  alias BandstockAPI.TileImage

  @doc """
  Returns the list of tiles.

  ## Examples

      iex> list_tiles()
      [%Tile{}, ...]

  """
  def list_tiles do
    Repo.all(Tile)
  end

  def list_cards do
    Enum.map Repo.all(Tile), fn tile ->
      file_name = tile.tileimage[:file_name]
      original_url = TileImage.url({file_name, tile}, :original);
      original_url = String.slice(original_url, String.length("/priv/static"), String.length(original_url));
      thumb_url = TileImage.url({file_name, tile}, :thumb);
      thumb_url = String.slice(thumb_url, String.length("/priv/static"), String.length(thumb_url));

      %{name: tile.name,
        hash: tile.hash,
        image_full: original_url,
        image_thumb: thumb_url};
    end
  end

  @doc """
  Gets a single tile.

  Raises `Ecto.NoResultsError` if the Tile does not exist.

  ## Examples

      iex> get_tile!(123)
      %Tile{}

      iex> get_tile!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tile!(id), do: Repo.get!(Tile, id)

  @doc """
  Creates a tile.

  ## Examples

      iex> create_tile(%{field: value})
      {:ok, %Tile{}}

      iex> create_tile(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tile(attrs \\ %{}) do
    IO.inspect("***Game.create_tile***")


    changeset = %Tile{} |> Tile.changeset(attrs)
    {:ok, tile} = Repo.insert(changeset)
    IO.puts("***Leaving Game.create_tile***")
    {:ok, tile}
  end

  @doc """
  Updates a tile.

  ## Examples

      iex> update_tile(tile, %{field: new_value})
      {:ok, %Tile{}}

      iex> update_tile(tile, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tile(%Tile{} = tile, attrs) do
    tile
    |> Tile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tile.

  ## Examples

      iex> delete_tile(tile)
      {:ok, %Tile{}}

      iex> delete_tile(tile)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tile(%Tile{} = tile) do
    Repo.delete(tile)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tile changes.

  ## Examples

      iex> change_tile(tile)
      %Ecto.Changeset{source: %Tile{}}

  """
  def change_tile(%Tile{} = tile) do
    Tile.changeset(tile, %{})
  end


  @doc """
  Gets a single tile.
  ## Examples
      iex> get_tile_by_hash("FA343")
      %Tile{}
  """
  def get_tile_by_hash(hash), do: Repo.get_by(Tile, hash: hash)

  alias BandstockApi.Game.Board

  @doc """
  Returns the list of boards.

  ## Examples

      iex> list_boards()
      [%Board{}, ...]

  """
  def list_boards do
    Repo.all(Board)
  end

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123)
      %Board{}

      iex> get_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_board!(id), do: Repo.get!(Board, id)

  @doc """
  Creates a board.

  ## Examples

      iex> create_board(%{field: value})
      {:ok, %Board{}}

      iex> create_board(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_board(attrs \\ %{}) do
    IO.inspect("in create_board")
    IO.inspect(attrs);
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

  def gen_board(attrs \\ %{}) do
      IO.inspect("in gen_board");
      IO.inspect(attrs)
      BandstockApi.Identicon.main("matt");
      create_board(%{"name" => "Generated Board" <> random_string(5)})
  end

  # def gen_tile(%{"tile" => tile_params}) do
  #   IO.inspect("in tile_controller.create")
  #   board = Game.get_board!(1) #MFD TODO: put everything on board 1 until we're ready to get fancy
  #
  #   with  {:ok, tileimage} <- get_tileimage(tile_params),
  #         {:ok, filename} <- parse_filename(tileimage),
  #         #{:ok, name} <- parse_file_extension(filename),
  #         {:ok, tile_params} <- parse_tile_params(tile_params, tileimage),
  #         {:ok, %Tile{} = tile} <- Game.create_tile(tile_params),
  #         {:ok, %Board{} = board} <- Game.link_tile_and_board(tile, board)
  #   do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", tile_path(conn, :show, tile))
  #     |> render("show.json", tile: tile)
  #   else
  #     :error -> :error
  #   end
  # end


  @doc """
  Updates a board.

  ## Examples

      iex> update_board(board, %{field: new_value})
      {:ok, %Board{}}

      iex> update_board(board, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_board(%Board{} = board, attrs) do
    board
    |> Board.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Board.

  ## Examples

      iex> delete_board(board)
      {:ok, %Board{}}

      iex> delete_board(board)
      {:error, %Ecto.Changeset{}}

  """
  def delete_board(%Board{} = board) do
    Repo.delete(board)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking board changes.

  ## Examples

      iex> change_board(board)
      %Ecto.Changeset{source: %Board{}}

  """
  def change_board(%Board{} = board) do
    Board.changeset(board, %{})
  end

  @doc """
  Gets a single board.
  ## Examples
      iex> get_board_by_hash("FA343")
      %Board{}
  """
  def get_board_by_hash(hash), do: Repo.get_by(Board, hash: hash)


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking board changes.

  ## Examples

      iex> change_board(board)
      %Ecto.Changeset{source: %Board{}}

  """



  def link_tile_and_board(tile = %Tile{}, board = %Board{}) do
    IO.puts("In link_tile_and_board")
    board = Repo.preload(board, :tiles)
    tiles = board.tiles ++ [tile]
                |> Enum.map(&Ecto.Changeset.change/1)

    board
      |> Ecto.Changeset.change
      |> Ecto.Changeset.put_assoc(:tiles, tiles)
      |> Repo.update
  end

  def unlink_tile_and_board(tile = %Tile{}, board = %Board{}) do

    board = Repo.preload(board, :tiles)
    tiles = board.tiles ++ [tile]
                |> Enum.map(&Ecto.Changeset.change/1)

    board
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:tiles, tiles)
    |> Repo.update

  end


  def format_board(%{board: board}) do
    %{id: board.id,
      hash: board.hash}
  end

  def format_tile(%{tile: tile}) do
    %{id: tile.id,
      hash: tile.hash}
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.encode16 |> binary_part(0, length);
  end
end
