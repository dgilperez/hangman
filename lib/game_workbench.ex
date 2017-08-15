defmodule GameWorkbench do
  alias GameWorkbench.Initializer

  defdelegate play_game(number_of_games), to: Initializer
end
