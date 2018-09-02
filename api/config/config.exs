# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bandstock_api,
  ecto_repos: [BandstockApi.Repo]

# Configures the endpoint
config :bandstock_api, BandstockApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HenzngI+NiYh5yszZ4Yy9u1fl0q13/Q2ivpZ2hvOinc9cZT4H6+lWU6qYG6nDhs2",
  render_errors: [view: BandstockApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BandstockApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :arc,
  storage: Arc.Storage.Local, #Arc.Storage.S3, # or
  storage_dir: "uploads/now"
  #bucket: {:system, "AWS_S3_BUCKET"} # if using Amazon S3

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
