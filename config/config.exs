# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lexit_api,
  ecto_repos: [LexitApi.Repo]

# Configures the endpoint
config :lexit_api, LexitApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JF5v9R8J/f4bPo9H7BJpa1WOqYixKZ5sJuM9RBl8u6oucSuUb4bx80YO50I7n+K+",
  render_errors: [view: LexitApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LexitApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
