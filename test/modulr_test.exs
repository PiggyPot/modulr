defmodule ModulrTest do
  use ExUnit.Case
  doctest Modulr

  test "greets the world" do
    assert Modulr.hello() == :world
  end
end
