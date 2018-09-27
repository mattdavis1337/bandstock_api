defmodule BandstockApiWeb.TileControllerTest do
  use BandstockApiWeb.ConnCase

  alias BandstockApi.Game
  alias BandstockApi.Game.Tile

  @create_attrs %{hash: "some hash", name: "some name", tileimage: %{}}
  @update_attrs %{hash: "some updated hash", name: "some updated name"}
  @invalid_attrs %{hash: nil, name: nil, tileimage: %{}}

#  %BandstockApi.Game.Tile{
#  __meta__: #Ecto.Schema.Metadata<:loaded, "tiles">,
#  boards: #Ecto.Association.NotLoaded<association :boards is not loaded>,
#  hash: "F9E3CA2CD3FD4389",
#  id: 92,
#  inserted_at: ~N[2018-09-04 03:35:48.115718],
#  name: "x",
#  tileimage: %{
#    file_name: "F9E3CA2CD3FD4389.png",
#    updated_at: ~N[2018-09-04 03:35:48]
#  },
#  updated_at: ~N[2018-09-04 03:35:48.115727]
#}
#  {"data":{"name":"x","image_thumb":"/uploads/tileimages/F9E3CA2CD3FD4389_thumb.png","image_full":"/uploads/tileimages/F9E3CA2CD3FD4389_original.png","hash":"F9E3CA2CD3FD4389"}}





  def fixture(:tile) do
    {:ok, tile} = Game.create_tile(@create_attrs)
    tile
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tiles", %{conn: conn} do
      conn = get conn, tile_path(conn, :index)
      assert json_response(conn, 200) == []
    end
  end

  describe "create tile" do
    test "renders tile when data is valid", %{conn: conn} do
      conn = post conn, tile_path(conn, :create), tile: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, tile_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, tile_path(conn, :create), tile: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end

  end

  describe "update tile" do
    setup [:create_tile]

    test "renders tile when data is valid", %{conn: conn, tile: %Tile{id: id} = tile} do
      conn = put conn, tile_path(conn, :update, tile), tile: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, tile_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, tile: tile} do
      conn = put conn, tile_path(conn, :update, tile), tile: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tile" do
    setup [:create_tile]

    test "deletes chosen tile", %{conn: conn, tile: tile} do
      conn = delete conn, tile_path(conn, :delete, tile)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, tile_path(conn, :show, tile)
      end
    end
  end

  defp create_tile(_) do
    tile = fixture(:tile)
    {:ok, tile: tile}
  end
end
