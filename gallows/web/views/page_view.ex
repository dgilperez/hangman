defmodule Gallows.PageView do
  use Gallows.Web, :view

  def plural_of(word, 1), do: "1 #{word}"
  def plural_of(word, quantity) when quantity < 0 do
    { :safe, "<span style=\"color: red\">#{quantity} #{word}s</span>" }
  end
  def plural_of(word, quantity), do: "#{quantity} #{word}s"
end
