defmodule BandstockApiWeb.PageController do
  use BandstockApiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
