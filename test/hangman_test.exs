defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "initializes a new game" do
    assert %{ game_state: :initializing,
              turns_left: 7,
              letters: [_h|_t] } = Hangman.new_game
  end
end
