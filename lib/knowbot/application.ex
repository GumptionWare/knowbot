defmodule Knowbot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Knowbot.Repo,
      # Start the Telemetry supervisor
      KnowbotWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Knowbot.PubSub},
      # Start the Endpoint (http/https)
      KnowbotWeb.Endpoint,
      # Start a worker by calling: Knowbot.Worker.start_link(arg)
      # {Knowbot.Worker, arg}
      {Knowbot.Consumer, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Knowbot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KnowbotWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
