defmodule GameWorkbench do
  alias GameWorkbench.Initializer

  defdelegate play_game(number_of_games), to: Initializer

  # Runs a battery of game plays with different turns number to
  # find the number of turns needed to win 50% of the games
  def run do
    play_game(100)
  end
end
