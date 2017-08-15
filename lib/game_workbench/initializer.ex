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

  defp process_results(collection) do
    collection
    |> Enum.reduce(%{ won_count: 0, lost_count: 0, won: [], lost: [] },
         fn({won_or_lost, word}, acc) ->
           process_result({ won_or_lost, word }, acc)
         end)
  end

  defp process_result({ :won, word }, acc) do
    %{ acc |
      won_count: acc[:won_count] + 1,
      won: [ word | acc[:won] ],
    }
  end

  defp process_result({ :lost, word }, acc) do
    %{ acc |
      lost_count: acc[:lost_count] + 1,
      lost: [ word | acc[:lost] ],
    }
  end
end
