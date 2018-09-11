defmodule BandstockApiWeb.Router do
  use BandstockApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "http://localhost:8080"
    plug :accepts, ["json"]
  end

  scope "/", BandstockApiWeb do
    pipe_through :browser # Use the default browser stack
    resources "/bids", BidController
    get "/", PageController, :index
    get "/boards/new", BoardController, :new
    get "/tiles/new", TileController, :new

  end

  scope "/api", BandstockApiWeb do
    pipe_through :api # Use the api browser stack
    resources "/tiles", TileController, except: [:new, :edit]
    resources "/boards", BoardController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
  end


  # Other scopes may use custom stacks.
  # scope "/api", BandstockApiWeb do
  #   pipe_through :api
  # end
end
