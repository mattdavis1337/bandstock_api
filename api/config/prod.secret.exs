use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :bandstock_api, BandstockApiWeb.Endpoint,
  secret_key_base: "HDWeEIotRBA6c2LvYkfrjGG0lcQrsLKD2UJyDDydEQPgDyS6XUKeDiW3JtU7AnNn"

# Configure your database
config :bandstock_api, BandstockApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "bandstock_api_prod",
  pool_size: 15
