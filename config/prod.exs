use Mix.Config

config :mr_heckles, MrHecklesWeb.Endpoint,
  server: true,
  url: [host: "${APP_NAME}.gigalixirapp.com", port: 443],
  version: Mix.Project.config()[:version],
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

config :mr_heckles, MrHeckles.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  ssl: true,
  pool_size: 2

config :logger, level: :info
