defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  @responses %{
    :won           => { :success, "You escaped the hangman! Believe me. It's true" },
    :lost          => { :danger, "You died. Violently" },
    :good_guess    => { :success, "That's goddamm right" },
    :bad_guess     => { :warning, "Meh" },
    :already_used  => { :info, "Don't repeat yourself, please" },
  }

  def game_over?(%{ game_state: game_state }) do
    game_state in [ :won, :lost ]
  end

  def new_game_button(conn) do
    button("Play a new game", to: hangman_path(conn, :create_game), class: "btn btn-primary")
  end

  def game_state(state) do
    @responses[state]
    |> alert()
  end

  ###

  defp alert(nil), do: ""
  defp alert({ class, message }) do
    content_tag(:div, message, class: "alert alert-#{class}")
  end
end
