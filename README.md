# BandstockApi

The Elixir/Phoenix app lives in the bandstock_api/api folder.  The 'ui folder is no longer used and will likely be removed at some point.

* This project requires Elixir/Phoenix[Install Docs](https://hexdocs.pm/phoenix/installation.html#content)
* This project requires PostgreSQL (use HomeBrew `brew` or similar if possible) - [Postgres Installs](https://www.postgresql.org/download/)
* DB viewer like Postico (mac) recommended

  To start your Phoenix server:

In Terminal -
  * cd bandstock_api/api
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies in bandstock_api/api/assets with `npm install`
  * Start Phoenix endpoint in bandstock_api/api with `mix phx.server`

  * If Images are not displaying, try `brunch build` in api/assets
  * Run `brunch watch` in api/assets to monitor changes to static assets

  Troubleshooting
  * make sure postgres is running
  * make sure postgres username/password matches what is in api/config/dev.exs


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


* All the 3.js code lives in api/lib/bandstock_api_web/templates/three/three.html.eex
and
api/lib/bandstock_api_web/templates/three/main.html.eex

Interesting Files (TODO: Turn these into sections describing how the app works):
* Router: api/lib/bandstock_api_web/router.ex
* Dependencies: ./mix.exs
* GenServer Threads (Elixir's Magic): ./api/lib/bandstock_engine/tile_game/periodic_task.ex and engine.ex
* DB Migrations: /priv/repo/migrations
* FOV Slider Demo: api/lib/bandstock_api_web/templates/three/main.html.eex
* Tile Engine (broken): api/lib/bandstock_api_web/templates/three/three.html.eex
* Client Side Sockets: api/assets/js/socket.js
* Server Side Sockets: api/lib/bandstock_api_web/channels
* Priority Queue Data Structure (need more like this): api/lib/bandstock_api/data/priority_queue.ex

Basic Idea  (Read up on Game Loops here: http://www.koonsolo.com/news/dewitters-gameloop/ and here: http://gameprogrammingpatterns.com/game-loop.html):

1) The GenServer threads run constantly in memory keeping track of game state on the server.
2) Periodic pulses (currently every 1 second) sends "Delta Packets" to all connected clients.   
3) Delta Packets have information about what changed on the server, and a timestamp to tell when it happened relative to all the other changes.
4) Client puts these changes in a priority queue and does its best to make the changes happen at the correct time.
5) Server watches for client actions and when they happened and puts those in the queue for all the other clients to receive

Server is the source of truth, and is the arbiter when collisions happen.  


Note: .eex files are 'embedded elixir'  These pages are mostly standard html/js/css and .eex gives the option to include serverside data at rendertime



## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
