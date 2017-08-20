defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, State, Summary}

  def play(game = %State{ tally: %{ game_state: :won } }) do
    Summary.display(game)
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
    |> Summary.display
    |> Prompter.accept_move
    |> Mover.make_move
    |> play
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
