defmodule BandstockApi.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :name, :string
      add :hash, :string

      timestamps()
    end

  end
end
