defmodule BandstockApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :handle, :string
    field :hash, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :handle, :provider, :token, :admin, :hash])
    |> validate_required([:email, :handle, :provider, :token, :admin, :hash])
  end
end
