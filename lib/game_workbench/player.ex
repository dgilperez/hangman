defmodule GameWorkbench.Player do
  alias TextClient.{Mover, State}
  alias GameWorkbench.Guesser

  def play(%State{ tally: %{ game_state: game_state, letters: letters } }) when game_state in [:won, :lost] do
    { game_state, Enum.join(letters) }
  end

  def play(game = %State{ tally: %{ game_state: game_state } }) when game_state in [:initializing, :good_guess, :bad_guess, :already_used] do
    game |> continue
  end

  ###############################

  defp continue(game) do
    game
    |> Guesser.guess_move
    |> Mover.make_move
    |> play
  end
end
