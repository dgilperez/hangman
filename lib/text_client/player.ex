defmodule TextClient.Player do
  alias TextClient.State

  def play(%State{ tally: %{ game_state: :won } }) do
    exit_with_message("You WON!!!")
  end

  def play(%State{ tally: %{ game_state: :lost } }) do
    exit_with_message("You LOST :(")
  end

  def play(game = %State{ tally: %{ game_state: :good_guess } }) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{ tally: %{ game_state: :bad_guess } }) do
    continue_with_message(game, "Sorry, that isn't in the word")
  end

  def play(game = %State{ tally: %{ game_state: :already_used } }) do
    continue_with_message(game, "Letter already used")
  end

  def play(game = %State{ tally: %{ game_state: :initializing } }) do
    continue(game)
  end

  def continue(game) do
    game
    |> display
    |> prompt
    |> make_move
    |> play
  end

  def display(game) do
    game
  end

  def prompt(game) do
    game
  end

  def make_move(game) do
    game
  end

  defp continue_with_message(game, message) do
    IO.puts message
    continue(game)
  end

  defp exit_with_message(message) do
    IO.puts message
    exit(:normal)
  end
end
