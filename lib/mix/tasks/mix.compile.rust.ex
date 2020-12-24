defmodule Mix.Tasks.Compile.Rust do
  use Mix.Task.Compiler

  @impl Mix.Task.Compiler
  def run(_args) do
    {_, exit_code} = System.cmd(
      "cargo", ["build", "--release"],
      cd: "rust", into: IO.stream(:stdio, :line)
    )
    if exit_code == 0 do
      :ok
    else
      {:error, []}
    end
  end
end
