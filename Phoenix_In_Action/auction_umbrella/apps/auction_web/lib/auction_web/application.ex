defmodule AuctionWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AuctionWebWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:auction_web, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AuctionWeb.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AuctionWeb.Finch},
      # Start a worker by calling: AuctionWeb.Worker.start_link(arg)
      # {AuctionWeb.Worker, arg},
      # Start to serve requests, typically the last entry
      AuctionWebWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AuctionWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AuctionWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
