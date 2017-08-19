defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new,
  )

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints
    }
  end

  def new_game do
    new_game(Dictionary.random_word)
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      letters_used: MapSet.to_list(game.used)
    }
  end

  # def make_move(game, guess) do
  #   game = Game.make_move(game, guess)
  #   { game, tally(game) }
  # end

  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    game
    |> return_with_tally
  end

  def make_move(game, guess) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
    |> return_with_tally
  end

  ####################

  defp accept_move(game, _guess, _already_guest = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _already_guest) do
    game
    |> Map.put(:used, MapSet.put(game.used, guess))
    |> verify_guess(Enum.member?(game.letters, guess))
  end

  defp verify_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)
                |> MapSet.subset?(game.used)
                |> maybe_won
    game
    |> Map.put(:game_state, new_state)
  end

  defp verify_guess(game = %{ turns_left: 1 }, _bad_guess) do
    game
    |> Map.put(:game_state, :lost)
  end

  defp verify_guess(game = %{ turns_left: turns_left }, _bad_guess) do
    %{ game |
       game_state: :bad_guess,
       turns_left: turns_left - 1
     }
  end

  defp maybe_won(_won = true), do: :won
  defp maybe_won(_), do: :good_guess

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _reveal = true), do: letter
  defp reveal_letter(_letter, _not_reveal), do: "_"

  defp return_with_tally(game), do: { game, tally(game) }
end
