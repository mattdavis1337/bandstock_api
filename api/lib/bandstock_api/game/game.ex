defmodule BandstockApi.Game do
  @moduledoc """
  The Game context.
  """

  import Ecto.Query, warn: false
  alias BandstockApi.Repo

  alias BandstockApi.Game.Tile

  @doc """
  Returns the list of tiles.

  ## Examples

      iex> list_tiles()
      [%Tile{}, ...]

  """
  def list_tiles do
    Repo.all(Tile)
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
    %Tile{}
    |> Tile.changeset(attrs)
    |> Repo.insert()
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
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

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
end
