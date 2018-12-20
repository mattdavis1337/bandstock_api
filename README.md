# BandstockApi

The Elixir/Phoenix app lives in the bandstock_api/api folder.  The 'ui folder is no longer used and will likely be removed at some point.

This project requires Elixir/Phoenix[Install Docs](https://hexdocs.pm/phoenix/installation.html#content)
This project requires PostgreSQL (use HomeBrew `brew` or similar if possible) - [Postgres Installs](https://www.postgresql.org/download/)
DB viewer like Postico (mac) recommended

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

.eex files are 'embedded elixir'  This page is mostly standard html/js/css and we have the option to include serverside data at rendertime using .eex



## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
