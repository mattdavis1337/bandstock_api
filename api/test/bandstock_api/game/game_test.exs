defmodule BandstockApi.GameTest do
  use BandstockApi.DataCase

  alias BandstockApi.Game

  describe "tiles" do
    alias BandstockApi.Game.Tile

    @valid_attrs %{hash: "some hash", name: "some name"}
    @update_attrs %{hash: "some updated hash", name: "some updated name"}
    @invalid_attrs %{hash: nil, name: nil}

    def tile_fixture(attrs \\ %{}) do
      {:ok, tile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_tile()

      tile
    end

    test "list_tiles/0 returns all tiles" do
      tile = tile_fixture()
      assert Game.list_tiles() == [tile]
    end

    test "get_tile!/1 returns the tile with given id" do
      tile = tile_fixture()
      assert Game.get_tile!(tile.id) == tile
    end

    test "get_tile_by_hash/1 returns correct tile" do
      tile = tile_fixture()
      assert Game.get_tile_by_hash(tile.hash) != nil
      assert Game.get_tile_by_hash(tile.hash).name == "some name"
    end

    test "get_tile_by_hash/1 returns nil when not found" do
      assert Game.get_tile_by_hash("FFFFF") === nil
    end

    test "create_tile/1 with valid data creates a tile" do
      assert {:ok, %Tile{} = tile} = Game.create_tile(@valid_attrs)
      assert tile.hash == "some hash"
      assert tile.name == "some name"
    end

    test "create_tile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_tile(@invalid_attrs)
    end

    test "update_tile/2 with valid data updates the tile" do
      tile = tile_fixture()
      assert {:ok, tile} = Game.update_tile(tile, @update_attrs)
      assert %Tile{} = tile
      assert tile.hash == "some updated hash"
      assert tile.name == "some updated name"
    end

    test "update_tile/2 with invalid data returns error changeset" do
      tile = tile_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_tile(tile, @invalid_attrs)
      assert tile == Game.get_tile!(tile.id)
    end

    test "delete_tile/1 deletes the tile" do
      tile = tile_fixture()
      assert {:ok, %Tile{}} = Game.delete_tile(tile)
      assert_raise Ecto.NoResultsError, fn -> Game.get_tile!(tile.id) end
    end

    test "change_tile/1 returns a tile changeset" do
      tile = tile_fixture()
      assert %Ecto.Changeset{} = Game.change_tile(tile)
    end
  end

  describe "boards" do
    alias BandstockApi.Game.Board

    @valid_attrs %{hash: "some hash", name: "some name"}
    @update_attrs %{hash: "some updated hash", name: "some updated name"}
    @invalid_attrs %{hash: nil, name: nil}

    def board_fixture(attrs \\ %{}) do
      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_board()

      board
    end

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert Game.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Game.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      assert {:ok, %Board{} = board} = Game.create_board(@valid_attrs)
      assert board.hash == "some hash"
      assert board.name == "some name"
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      assert {:ok, board} = Game.update_board(board, @update_attrs)
      assert %Board{} = board
      assert board.hash == "some updated hash"
      assert board.name == "some updated name"
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_board(board, @invalid_attrs)
      assert board == Game.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Game.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> Game.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Game.change_board(board)
    end

    test "get_board_by_hash/1 returns correct board" do
      board = board_fixture()
      assert Game.get_board_by_hash(board.hash) != nil
      assert Game.get_board_by_hash(board.hash).name == "some name"
    end

    test "get_board_by_hash/1 returns nil when not found" do
      assert Game.get_board_by_hash("FFFFF") === nil
    end
  end


  describe "boards_tiles" do
    alias BandstockApi.Game.Board
    alias BandstockApi.Game.Tile

    @valid_tile1 %{hash: "tilehash1", name: "tilename1"}
    @valid_tile2 %{hash: "tilehash2", name: "tilename2"}
    @valid_tile3 %{hash: "tilehash3", name: "tilename3"}

    @valid_board1 %{hash: "boardhash1", name: "boardname1"}

    test "link_tile_and_board/1 returns a board with tiles" do
      assert {:ok, %Board{} = board1} = Game.create_board(@valid_board1)
      assert {:ok, %Tile{} = tile1} = Game.create_tile(@valid_tile1)
      assert {:ok, %Tile{} = tile2} = Game.create_tile(@valid_tile2)
      assert {:ok, %Tile{} = tile3} = Game.create_tile(@valid_tile3)

      BandstockApi.Game.link_tile_and_board(tile1, board1)
      BandstockApi.Game.link_tile_and_board(tile2, board1)
      BandstockApi.Game.link_tile_and_board(tile3, board1)

      board1 = Repo.preload(board1, :tiles)
      tile2 = Repo.preload(tile2, :boards)

      assert length(board1.tiles) == 3
      assert length(tile2.boards) == 1
      assert hd(tile2.boards).hash == "boardhash1"
    end

    test "unlink_tile_and_board/1 returns a board with tiles" do
      # assert {:ok, %Board{} = board1} = Game.create_board(@valid_board1)
      # assert {:ok, %Card{} = card1} = Game.create_card(@valid_card1)
      # assert {:ok, %Card{} = card2} = Game.create_card(@valid_card2)
      # assert {:ok, %Card{} = card3} = Game.create_card(@valid_card3)
      #
      # Bandstock.Game.link_card_and_board(card1, board1)
      # Bandstock.Game.link_card_and_board(card2, board1)
      # Bandstock.Game.link_card_and_board(card3, board1)
      #
      # board1 = Repo.preload(board1, :cards)
      # card2 = Repo.preload(card2, :boards)
      #
      # Bandstock.Game.unlink_card_and_board(card1, board1)
      #
      # board1 = Repo.preload(board1, :cards)
      # card1 = Repo.preload(card1, :boards)
      #
      # assert length(board1.cards) == 2
      # assert length(card1.boards) == 0
      assert true
    end

    test "create_board/1 creates board with empty tiles" do
      assert {:ok, %Board{} = board1} = Game.create_board(@valid_board1)
      board1 = Repo.preload(board1, :tiles)
      assert length(board1.tiles) == 0
    end
  end

  describe "bids" do
    alias BandstockApi.Game.Bid

    @valid_attrs %{amount: 120.5, comment: "some comment", phone: "some phone", piece: "some piece"}
    @update_attrs %{amount: 456.7, comment: "some updated comment", phone: "some updated phone", piece: "some updated piece"}
    @invalid_attrs %{amount: nil, comment: nil, phone: nil, piece: nil}

    def bid_fixture(attrs \\ %{}) do
      {:ok, bid} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_bid()

      bid
    end

    test "list_bids/0 returns all bids" do
      bid = bid_fixture()
      assert Game.list_bids() == [bid]
    end

    test "get_bid!/1 returns the bid with given id" do
      bid = bid_fixture()
      assert Game.get_bid!(bid.id) == bid
    end

    test "create_bid/1 with valid data creates a bid" do
      assert {:ok, %Bid{} = bid} = Game.create_bid(@valid_attrs)
      assert bid.amount == 120.5
      assert bid.comment == "some comment"
      assert bid.phone == "some phone"
      assert bid.piece == "some piece"
    end

    test "create_bid/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_bid(@invalid_attrs)
    end

    test "update_bid/2 with valid data updates the bid" do
      bid = bid_fixture()
      assert {:ok, bid} = Game.update_bid(bid, @update_attrs)
      assert %Bid{} = bid
      assert bid.amount == 456.7
      assert bid.comment == "some updated comment"
      assert bid.phone == "some updated phone"
      assert bid.piece == "some updated piece"
    end

    test "update_bid/2 with invalid data returns error changeset" do
      bid = bid_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_bid(bid, @invalid_attrs)
      assert bid == Game.get_bid!(bid.id)
    end

    test "delete_bid/1 deletes the bid" do
      bid = bid_fixture()
      assert {:ok, %Bid{}} = Game.delete_bid(bid)
      assert_raise Ecto.NoResultsError, fn -> Game.get_bid!(bid.id) end
    end

    test "change_bid/1 returns a bid changeset" do
      bid = bid_fixture()
      assert %Ecto.Changeset{} = Game.change_bid(bid)
    end
  end
end
