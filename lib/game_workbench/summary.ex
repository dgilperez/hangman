defmodule GameWorkbench.Summary do
  def process_results(collection) do
    collection
    |> Enum.reduce(%{ won_count: 0, lost_count: 0, won: [], lost: [], number_of_games: 0 },
         fn({won_or_lost, word}, acc) ->
           process_result({ won_or_lost, word }, acc)
         end)
    |> threshold_passed
  end

  #####

  defp process_result({ :won, word }, acc) do
    %{ acc |
       number_of_games: acc[:number_of_games] + 1,
       won_count: acc[:won_count] + 1,
       won: [ word | acc[:won] ],
    }
  end

  defp process_result({ :lost, word }, acc) do
    %{ acc |
       number_of_games: acc[:number_of_games] + 1,
       lost_count: acc[:lost_count] + 1,
       lost: [ word | acc[:lost] ],
    }
  end

  defp threshold_passed(%{ won_count: won_count, won: won, number_of_games: number_of_games })
  when won_count / number_of_games > 0.5 do
    summary_message("--- WON ---\n", stats_message(won_count, number_of_games), ["\n" | won])
  end

  defp threshold_passed(%{ won_count: won_count, won: won, number_of_games: number_of_games })
  when won_count / number_of_games > 0.05 do
    summary_message("--- SOMETHING THERE ---\n", stats_message(won_count, number_of_games), ["\n" | won])
  end

  defp threshold_passed(%{ won_count: won_count, number_of_games: number_of_games }) do
    summary_message("--- LOST ---\n", stats_message(won_count, number_of_games), [])
  end

  defp summary_message(message, stats, won_words) do
    IO.puts [
      message,
      stats,
      won_words
    ]
  end

  defp stats_message(won, total) do
    "#{won} games won out of #{total} (#{won / total * 100}%)"
  end
end
