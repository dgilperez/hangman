defmodule GameWorkbench.Initializer do
  alias GameWorkbench.{Player, Summary}
  alias TextClient.State

  def play_game do
    play_game(1)
  end

  def play_game(number_of_games) when number_of_games > 0 do
    for _game_number <- 1..number_of_games do
      IO.puts "Playing game ##{_game_number}"
      start()
    end
    |> Summary.process_results
  end

  #############################################

  defp start do
    Hangman.new_game
    |> setup_state
    |> Player.play
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally:        Hangman.tally(game),
    }
  end
end
