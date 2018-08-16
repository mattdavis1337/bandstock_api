defmodule BandstockApiWeb.UserView do
  use BandstockApiWeb, :view
  alias BandstockApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      handle: user.handle,
      provider: user.provider,
      token: user.token,
      admin: user.admin,
      hash: user.hash}
  end
end
