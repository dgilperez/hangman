defmodule GameBench do
  use Benchfella

  bench "10 plays" do
    GameWorkbench.play_game(10)
  end

  # bench "100 plays" do
  #   GameWorkbench.play_game(100)
  # end

  # bench "1000 plays" do
  #   GameWorkbench.play_game(1000)
  # end
end
