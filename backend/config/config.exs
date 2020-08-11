# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mr_heckles,
  ecto_repos: [MrHeckles.Repo]

# Configures the endpoint
config :mr_heckles, MrHecklesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wfQu4/cOFgWQkHAqd2rO8AOvhrvGaqTuL5WyxlK4PLRm2XWf8BhAdx3Ex3/SyBRT",
  render_errors: [view: MrHecklesWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MrHeckles.PubSub,
  live_view: [signing_salt: "zwjWwhGD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
