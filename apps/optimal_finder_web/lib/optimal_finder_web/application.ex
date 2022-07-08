defmodule OptimalFinderWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      OptimalFinderWeb.Telemetry,
      # Start the Endpoint (http/https)
      OptimalFinderWeb.Endpoint
      # Start a worker by calling: OptimalFinderWeb.Worker.start_link(arg)
      # {OptimalFinderWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OptimalFinderWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OptimalFinderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
