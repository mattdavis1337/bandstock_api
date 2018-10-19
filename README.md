# BandstockApi

The Elixir/Phoenix app lives in the bandstock_api/api folder.  The UI folder is no longer used and will likely be removed at some point.

This project requires Elixir/Phoenix & Postgresql [Install Docs](https://hexdocs.pm/phoenix/installation.html#content)

  To start your Phoenix server:

  * cd bandstock_api/api
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

  * If Images are not displaying, try `brunch build` in api/assets

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


* All the 3.js code lives in api/lib/bandstock_api_web/templates/three/three.html.eex

.eex files are 'embedded elixir'  This page is mostly standard html/js/css and we have the option to include serverside data at rendertime using .eex



## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
