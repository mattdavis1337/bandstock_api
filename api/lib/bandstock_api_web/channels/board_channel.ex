defmodule BandstockApiWeb.BoardChannel do
  use Phoenix.Channel
  alias BandstockApi.Repo
  alias BandstockApiWeb.BoardView

  #join returns {:ok, socket} or {:ok, reply, socket}. To deny access, we return {:error, reply}.

  def join("board:*", _message, socket) do
    IO.puts("in join board:*")
    {:ok, socket}
  end

  def join("board:lobby", _message, socket) do
    IO.puts("in join board:lobby")
    {:ok, socket}
  end

  def join("board:" <> board_id, _params, socket) do
    IO.puts("in join board:" <> board_id)

    board = BandstockApi.Game.get_board!(board_id) |>
    Repo.preload(:tiles)

    board_json = BoardView.render("board.json", %{board: board})

    reply = %{"board_id" => board_id, "board" => board_json};
    IO.puts("Reply")

    #{:error, %{reason: "unauthorized"}}
    {:ok, reply, socket}
  end

  def handle_out("board:" <> board_id, _params, socket) do

  end

  def handle_in("board_input", %{"body" => body}, socket) do
    IO.puts("received board_input");
    #broadcast! socket, "board_output", %{body: body <> "-output"}
    {:noreply, socket}
  end
end
