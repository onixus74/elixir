defmodule ExApp.Application do
  use Application
  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: ExApp, options: [port: 4000])
    ]
    opts = [strategy: :one_for_one, name: ExApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
