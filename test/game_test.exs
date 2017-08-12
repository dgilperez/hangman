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

  test "state isn't changed for :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game |> Map.put(:game_state, state)
      assert { ^game, _ } = Game.make_move(game, "XXX")
    end
  end

  test "turns_left is decremented if guess is incorrect" do
    game = Game.new_game
           |> Map.put(:letters, ["p", "a", "n"])
           |> Map.put(:turns_left, 100)
    { new_game, _ } = Game.make_move(game, "vino")

    assert new_game.game_state != :won
    assert new_game.turns_left == 99
  end

  test "state is changed to :won if guess is correct" do
    game = Game.new_game |> Map.put(:letters, ["p", "a", "n"])
    { new_game, _ } = Game.make_move(game, "pan")
    assert new_game.game_state == :won
  end
end
