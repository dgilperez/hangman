defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "initializes a new game" do
    assert %{ game_state: :initializing,
              turns_left: 7,
              letters: [_h|_t] } = Hangman.new_game
  end

  test "makes a move" do
    game = Hangman.new_game |> Map.put(:letters, ["p", "a", "n"])
    tally = %{ game_state: :good_guess, turns_left: 7, letters: ["p", "_", "_"], letters_used: ["p"] }
    assert { game, ^tally } = Hangman.make_move(game, "p")
    assert Hangman.tally(game) == tally
  end
end
