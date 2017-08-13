defmodule TextClient.Mover do
  alias TextClient.State

  def make_move(game = %State{}) do
    { new_game_service, tally } = Hangman.make_move(game.game_service, game.guess)
    %State{ game | game_service: new_game_service, tally: tally}
  end
end
