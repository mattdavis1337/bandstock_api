defmodule BandstockApi.Repo.Migrations.DropTilesBoards do
  use Ecto.Migration

  def change do
    drop_if_exists table("tiles_boards")
  end
end
