defmodule BandstockApi.Game.Bid do
  use Ecto.Schema
  import Ecto.Changeset


  schema "bids" do
    field :name, :string
    field :amount, :float
    field :comment, :string
    field :phone, :string
    field :piece, :string
    belongs_to :tile, EctoAssoc.Tile

    timestamps()
  end

  @doc false
  def changeset(bid, attrs) do
    bid
    |> cast(attrs, [:name, :phone, :piece, :amount, :comment])
    |> validate_required([:name, :phone, :piece, :amount, :comment])
  end
end
