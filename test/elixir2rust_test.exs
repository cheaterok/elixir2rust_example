defmodule Elixir2rustTest do
  use ExUnit.Case
  doctest Elixir2rust

  test "greets the world" do
    assert Elixir2rust.hello() == :world
  end
end
