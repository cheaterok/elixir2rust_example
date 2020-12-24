defmodule Elixir2rust.Application do
  use Application

  def start(_type, _args) do
    children = [
      Elixir2rust
    ]

    opts = [strategy: :one_for_one, name: Elixir2rust.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
