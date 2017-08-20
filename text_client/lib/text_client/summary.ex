defmodule TextClient.Summary do
  def display(game = %{ tally: tally }) do
    IO.puts [
      "\n",
      "Word so far:    #{to_sentence(tally.letters)}\n",
      "Letters used:   #{to_sentence(tally.letters_used)}\n",
      "Guesses so far: #{tally.turns_left}\n",
    ]
    game
  end

  defp to_sentence(list) do
    Enum.join(list, " ")
  end
end
