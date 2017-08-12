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
      assert { ^game, _ } = Game.make_move(game, "x")
    end
  end

  test "turns_left is decremented if guess is incorrect" do
    game = Game.new_game
           |> Map.put(:letters, ["p", "a", "n"])
           |> Map.put(:turns_left, 100)
    { new_game, _ } = Game.make_move(game, "v")

    assert new_game.turns_left == 99
  end

  test "guess is recorded if good guess" do
    game = Game.new_game |> Map.put(:letters, ["p", "a", "n"])
    { new_game, _ } = Game.make_move(game, "p")

    assert new_game.game_state == :good_guess
    assert new_game.turns_left == 7
    assert MapSet.member?(new_game.used, "p")
  end

  test "guess is recorded if bad guess" do
    game = Game.new_game |> Map.put(:letters, ["p", "a", "n"])
    { new_game, _ } = Game.make_move(game, "x")

    assert new_game.game_state == :bad_guess
    assert new_game.turns_left == 6
    assert MapSet.member?(new_game.used, "x")
  end

  test "state is changed to :already_used if guess is repeated" do
    { game, _ } = Game.new_game
                  |> Map.put(:letters, ["p", "a", "n"])
                  |> Game.make_move("p")

    assert MapSet.member?(game.used, "p")
    assert game.game_state != :already_used

    { new_game, _ } = Game.make_move(game, "p")

    assert MapSet.member?(new_game.used, "p")
    assert new_game.game_state == :already_used
  end

  test "game is lost if turns_left is 0 or less" do
    for turns_left <- [-100, -1, 0] do
      { game, _ } = Game.new_game
                    |> Map.put(:turns_left, turns_left)
                    |> Game.make_move("x")
      assert game.game_state == :lost
    end
  end

  test "state is changed to :won if guess is correct" do
    game = Game.new_game |> Map.put(:letters, ["p", "a", "n"])
    { new_game, _ } = Game.make_move(game, "p")
    { new_game, _ } = Game.make_move(new_game, "a")
    { new_game, _ } = Game.make_move(new_game, "n")

    assert new_game.game_state == :won
  end
end
