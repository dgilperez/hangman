defmodule GallowsWeb.HangmanView.Helpers.GameStateHelper do
  import Phoenix.HTML.Tag, only: [ content_tag: 3 ]

  @responses %{
    :won           => { :success, "You escaped the hangman! Believe me. It's true" },
    :lost          => { :danger, "You died. Violently" },
    :good_guess    => { :success, "That's goddamm right" },
    :bad_guess     => { :warning, "Meh" },
    :already_used  => { :info, "Don't repeat yourself, please" },
  }

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
