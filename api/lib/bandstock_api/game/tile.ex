defmodule BandstockApi.Game.Tile do
  use Arc.Ecto.Schema
  use Ecto.Schema
  import Ecto.Changeset

  schema "tiles" do
    field :hash, :string
    field :name, :string
    field :x, :integer
    field :y, :integer
    field :z, :integer
    field :type, :string

    field :tileimage, BandstockAPI.TileImage.Type
    many_to_many :boards, BandstockApi.Game.Board, join_through: "tiles_boards"
    timestamps()
  end

  @doc false
  def changeset(tile, attrs) do
    tile
    |> cast(attrs, [:name, :hash, :tileimage, :x, :y, :z, :type])
    |> cast_attachments(attrs, [:tileimage])
    |> unique_constraint(:hash)
    |> validate_required([:name, :hash, :x, :y, :z, :type])
  end
end
