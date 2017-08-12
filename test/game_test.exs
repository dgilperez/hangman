defmodule GameTest do
  use ExUnit.Case
  doctest Hangman.Game

  alias Hangman.Game

  test "new_game returns static structure" do
    game = Game.new_game

    assert game.game_state == :initializing
    assert game.turns_left == 7
    assert length(game.letters) > 0
  end

  test "each element of the letters list
        is a lower-case ASCII character (“a” to “z”)" do
    game = Game.new_game

    assert game.letters
           |> Enum.map(&(String.match?(&1, ~r/[a-z]/)))
  end
end
