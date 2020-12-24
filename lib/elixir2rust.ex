defmodule Elixir2rust do
  use GenServer

  require Logger

  @executable_path ~w(rust target release rust)s |> Path.join()

  def start_link([]) do
    GenServer.start_link(__MODULE__, [])
  end

  @impl true
  def init([]) do
    port = open_port()
    Kernel.send(self(), :send)
    {:ok, port}
  end

  @impl true
  def handle_call({:send, data}, _from, port) do
    true = send_message(port, data)
    {:reply, :ok, port}
  end

  @impl true
  def handle_info(:send, port) do
    send_message(port, "TEST")
    Process.send_after(self(), :send, 1000)
    {:noreply, port}
  end
  def handle_info({port, {:data, data}}, port) do
    Logger.info("Got #{data}")
    {:noreply, port}
  end

  defp open_port() do
    Logger.info("Opening port to #{@executable_path}")
    Port.open(
      {:spawn_executable, @executable_path},
      [
        {:args, ["elixir"]},
        :nouse_stdio,
        :binary
      ]
    )
  end

  defp send_message(port, message) do
    Logger.info("Sending #{message}")
    Port.command(port, "#{message}\n")
  end
end
