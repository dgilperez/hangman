defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
  )

  def new_game do
    %Hangman.Game{
      letters: Dictionary.random_word |> String.codepoints
    }
  end

  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end

  def make_move(game = %{ game_state: state }, guess) do
    if guess == game.letters |> Enum.join do
      { Map.put(game, :game_state, :won), tally(game) }
    else
      { Map.put(game, :turns_left, game.turns_left - 1), tally(game) }
    end
  end

  def tally(_game) do
    123
  end
end
