defmodule BandstockApi.Repo.Migrations.AddTileimage do
  use Ecto.Migration

  def change do
    add :tileimage, :string
  end
end
