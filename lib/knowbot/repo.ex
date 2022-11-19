defmodule Knowbot.Repo do
  use Ecto.Repo,
    otp_app: :knowbot,
    adapter: Ecto.Adapters.Postgres
end
