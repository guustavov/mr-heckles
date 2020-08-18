defmodule MrHeckles.Repo do
  use Ecto.Repo,
    otp_app: :mr_heckles,
    adapter: Ecto.Adapters.Postgres
end
