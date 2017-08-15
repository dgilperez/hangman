defmodule GameWorkbenchTest do
  use ExUnit.Case
  doctest GameWorkbench

  test "greets the world" do
    assert GameWorkbench.hello() == :world
  end
end
