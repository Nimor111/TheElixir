defmodule TheElixir.Repo do
  use Ecto.Repo, otp_app: :the_elixir, adapter: Ecto.Adapters.Postgres
end
