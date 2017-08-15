defmodule GameWorkbench.Initializer do
  alias GameWorkbench.Player
  alias TextClient.State

  def play_game do
    play_game(1)
  end

  def play_game(number_of_games) when number_of_games > 0 do
    for game_number <- 1..number_of_games do
      IO.puts "Playing game ##{game_number}"
      start()
    end
    |> process_results
  end

  #####

  defp process_results(collection) do
    collection
    |> IO.inspect
    |> Enum.group_by(fn { won_or_lost, _ } -> won_or_lost end, fn { _, letters } -> letters end)
  end

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
