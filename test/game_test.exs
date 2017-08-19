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
      { new_game, _tally } = Game.make_move(game, "x")
      assert new_game == game
    end
  end

  test "turns_left is decremented if guess is incorrect" do
    game = Game.new_game("pan")
           |> Map.put(:turns_left, 100)
    { game, _tally } = Game.make_move(game, "v")

    assert game.turns_left == 99
  end

  test "guess is recorded if good guess" do
    game = Game.new_game("pan")
    { game, _tally } = Game.make_move(game, "p")

    assert game.game_state == :good_guess
    assert game.turns_left == 7
    assert MapSet.member?(game.used, "p")
  end

  test "guess is recorded if bad guess" do
    game = Game.new_game("pan")
    { game, _tally } = Game.make_move(game, "x")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    assert MapSet.member?(game.used, "x")
  end

  test "state is changed to :already_used if guess is repeated" do
    game = Game.new_game("pan")
    { game, _tally } = Game.make_move(game, "p")

    assert MapSet.member?(game.used, "p")
    assert game.game_state != :already_used

    { game, _tally } = Game.make_move(game, "p")

    assert MapSet.member?(game.used, "p")
    assert game.game_state == :already_used
  end

  test "won game: state is changed to :won if guess is correct" do
    moves = [
      { "p", :good_guess },
      { "a", :good_guess },
      { "n", :won },
    ]

    game = Game.new_game("pan")

    Enum.reduce(moves, game, fn ({ guess, state }, game) ->
      { game, _tally } = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end)
  end

  test "lost game: game is lost under a bad guess and no turns left" do
    moves = [
      { "t", :bad_guess },
      { "u", :bad_guess },
      { "v", :bad_guess },
      { "w", :bad_guess },
      { "x", :bad_guess },
      { "y", :bad_guess },
      { "z", :lost },
    ]

    game = Game.new_game("pan")

    Enum.reduce(moves, game, fn ({ guess, state }, game) ->
      { game, _tally } = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end)
  end
end
