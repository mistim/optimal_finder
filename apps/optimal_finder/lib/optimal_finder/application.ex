defmodule OptimalFinder.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      OptimalFinder.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: OptimalFinder.PubSub}
      # Start a worker by calling: OptimalFinder.Worker.start_link(arg)
      # {OptimalFinder.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: OptimalFinder.Supervisor)
  end
end
