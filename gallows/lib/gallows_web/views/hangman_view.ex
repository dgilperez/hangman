defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import GallowsWeb.HangmanView.Helpers.GameStateHelper

  def game_over?(%{ game_state: game_state }) do
    game_state in [ :won, :lost ]
  end

  def new_game_button(conn) do
    button("Play a new game", to: hangman_path(conn, :create_game), class: "btn btn-primary")
  end

  def turn(left, target) when target >= left, do: ""
  def turn(left, target), do: "faint"
end
