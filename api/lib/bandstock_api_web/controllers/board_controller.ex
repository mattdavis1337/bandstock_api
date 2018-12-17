defmodule BandstockApiWeb.BoardController do
  use BandstockApiWeb, :controller

  alias BandstockApi.Game
  alias BandstockApi.Game.Board

  action_fallback BandstockApiWeb.FallbackController

  def new(conn, _params) do
    changeset = Game.change_board(%Board{})
    render(conn, "new.html", changeset: changeset)
  end

  def gen(conn, _params) do
    IO.inspect("gen")
    IO.inspect(_params);
    changeset = Game.change_board(%Board{})
    render(conn, "gen.html", changeset: changeset)
  end

  def gen_action(conn, %{"board" => board_params}) do
    IO.inspect("gen_action")
    IO.inspect(board_params);
    with {:ok, %Board{} = board} <- Game.gen_board(board_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", board_path(conn, :show, board))
      |> render("show.json", board: board)
    end
  end

  def index(conn, _params) do
    boards = Game.list_boards()
    render(conn, "index.json", boards: boards)
  end

  def create(conn, %{"board" => board_params}) do
    with {:ok, %Board{} = board} <- Game.create_board(board_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", board_path(conn, :show, board))
      |> render("show.json", board: board)
    end
  end

  def show(conn, %{"id" => id}) do
    board = Game.get_board!(id)
    render(conn, "show.json", board: board)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = Game.get_board!(id)

    with {:ok, %Board{} = board} <- Game.update_board(board, board_params) do
      render(conn, "show.json", board: board)
    end
  end

  def link_tile_and_board(conn, %{}) do

  end

  def delete(conn, %{"id" => id}) do
    board = Game.get_board!(id)
    with {:ok, %Board{}} <- Game.delete_board(board) do
      send_resp(conn, :no_content, "")
    end
  end
end
