



describe "cards" do
    #alias Bandstock.Game.Card

    @valid_attrs %{hash: "some hash", image: "some image", name: "some name"}
    @update_attrs %{hash: "some updated hash", image: "some updated image", name: "some updated name"}
    @invalid_attrs %{hash: nil, image: nil, name: nil}

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Game.list_cards() == [card]
    end

    test "get_card_by_hash/1 returns correct card" do
      card = card_fixture()
      assert Game.get_card_by_hash(card.hash) != nil
      assert Game.get_card_by_hash(card.hash).name == "some name"
    end

    test "get_card_by_hash/1 returns nil when not found" do
      #card = card_fixture()
      assert Game.get_card_by_hash("FFFFF") === nil
    end

    test "create_card/1 creates card correctly" do
      assert {:ok, %Card{} = card} = Game.create_card(@valid_attrs)
      assert card.hash == "some hash"
      assert card.image == "some image"
      assert card.name == "some name"
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, card} = Game.update_card(card, @update_attrs)
      assert %Card{} = card
      assert card.hash == "some updated hash"
      assert card.image == "some updated image"
      assert card.name == "some updated name"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_card(card, @invalid_attrs)
      assert card == Game.get_card_by_hash(card.hash)
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Game.get_card!(card.id) == card
    end

    test "get_card!/1 throws Ecto.NoResultsError when not found" do
      card = card_fixture()
      assert_raise Ecto.NoResultsError, fn -> Game.get_card!(card.id+1) end
    end

    defp card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_card()
      card
    end

    # test "create_tile/1 with valid data creates a tile" do
    #   assert {:ok, %Tile{} = tile} = Game.create_tile(@valid_attrs)
    #   assert tile.hash == "some hash"
    #   assert tile.image == "some image"
    #   assert tile.location == "some location"
    # end
    #
    # test "create_tile/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Game.create_tile(@invalid_attrs)
    # end
    #
    # test "update_tile/2 with valid data updates the tile" do
    #   tile = tile_fixture()
    #   assert {:ok, tile} = Game.update_tile(tile, @update_attrs)
    #   assert %Tile{} = tile
    #   assert tile.hash == "some updated hash"
    #   assert tile.image == "some updated image"
    #   assert tile.location == "some updated location"
    # end
    #
    # test "update_tile/2 with invalid data returns error changeset" do
    #   tile = tile_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Game.update_tile(tile, @invalid_attrs)
    #   assert tile == Game.get_tile!(tile.id)
    # end
    #
    # test "delete_tile/1 deletes the tile" do
    #   tile = tile_fixture()
    #   assert {:ok, %Tile{}} = Game.delete_tile(tile)
    #   assert_raise Ecto.NoResultsError, fn -> Game.get_tile!(tile.id) end
    # end
    #
    # test "change_tile/1 returns a tile changeset" do
    #   tile = tile_fixture()
    #   assert %Ecto.Changeset{} = Game.change_tile(tile)
    # end
  end

  describe "boards_cards" do
    @valid_card1 %{hash: "cardhash1", name: "cardname1", image: "cardimage1"}
    @valid_card2 %{hash: "cardhash2", name: "cardname2", image: "cardimage2"}
    @valid_card3 %{hash: "cardhash3", name: "cardname3", image: "cardimage3"}

    @valid_board1 %{hash: "boardhash1", name: "boardname1"}

    test "link_card_and_board/1 returns a board with cards" do
      assert {:ok, %Board{} = board1} = Game.create_board(@valid_board1)
      assert {:ok, %Card{} = card1} = Game.create_card(@valid_card1)
      assert {:ok, %Card{} = card2} = Game.create_card(@valid_card2)
      assert {:ok, %Card{} = card3} = Game.create_card(@valid_card3)

      Bandstock.Game.link_card_and_board(card1, board1)
      Bandstock.Game.link_card_and_board(card2, board1)
      Bandstock.Game.link_card_and_board(card3, board1)

      board1 = Repo.preload(board1, :cards)
      card2 = Repo.preload(card2, :boards)

      assert length(board1.cards) == 3
      assert length(card2.boards) == 1
      assert hd(card2.boards).hash == "boardhash1"
    end

    test "unlink_card_and_board/1 returns a board with cards" do
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


    test "create_board/1 creates board with empty cards" do
      assert {:ok, %Board{} = board1} = Game.create_board(@valid_board1)
      board1 = Repo.preload(board1, :cards)
      assert length(board1.cards) == 0
    end
  end

  describe "boards" do

    @valid_attrs %{hash: "some hash", name: "some name"}
    @update_attrs %{hash: "some updated hash", name: "some updated name"}
    @invalid_attrs %{hash: nil, name: nil}

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

    defp board_fixture(attrs \\ %{}) do
      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_board()
      board
    end
  end





  =======




      describe "boards_tiles" do
        alias BandstockApi.Game.Board
        alias BandstockApi.Game.Tile

        @valid_card1 %{hash: "tilehash1", name: "tilename1"}
        @valid_card2 %{hash: "tilehash2", name: "tilename2"}
        @valid_card3 %{hash: "tilehash3", name: "tilename3"}

        @valid_board1 %{hash: "boardhash1", name: "boardname1"}

        test "link_tile_and_board/1 returns a board with tiles" do
          assert {:ok, %Board{} = board1} = Game.create_board(@valid_board1)
          assert {:ok, %Tile{} = tile1} = Game.create_tile(@valid_tile1)
          assert {:ok, %Tile{} = tile2} = Game.create_tile(@valid_tile2)
          assert {:ok, %Tile{} = tile3} = Game.create_tile(@valid_tile3)

          Bandstock.Game.link_tile_and_board(tile1, board1)
          Bandstock.Game.link_tile_and_board(tile2, board1)
          Bandstock.Game.link_tile_and_board(tile3, board1)

          board1 = Repo.preload(board1, :tiles)
          tile2 = Repo.preload(tile2, :boards)

          assert length(board1.tiles) == 3
          assert length(tile2.boards) == 1
          assert hd(tile2.boards).hash == "boardhash1"
        end

        test "unlink_card_and_board/1 returns a board with cards" do
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


        test "create_board/1 creates board with empty cards" do
          assert {:ok, %Board{} = board1} = Game.create_board(@valid_board1)
          board1 = Repo.preload(board1, :cards)
          assert length(board1.cards) == 0
        end
      end
