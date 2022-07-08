defmodule OptimalFinder.Repo do
  use Ecto.Repo,
    otp_app: :optimal_finder,
    adapter: Ecto.Adapters.MyXQL
end
