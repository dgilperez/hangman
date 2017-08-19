defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "initializes a new game, returns a pid" do
    assert is_pid(Hangman.new_game) == true
  end
end
