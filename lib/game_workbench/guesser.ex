defmodule GameWorkbench.Guesser do
  alias TextClient.State

  def guess_move(game = %State{ game_service: %{ used: used } }) do
    letter = guess_letter(used)
    Map.put(game, :guess, letter)
  end

  ######

  def guess_letter(used) do
    alphabet() -- Enum.uniq(used)
    |> Enum.random
  end

  defp alphabet do
    for n <- ?a..?z, do: << n :: utf8 >>
  end
end
