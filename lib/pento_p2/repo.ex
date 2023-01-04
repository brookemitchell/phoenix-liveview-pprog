defmodule PentoP2.Repo do
  use Ecto.Repo,
    otp_app: :pento_p2,
    adapter: Ecto.Adapters.Postgres
end
