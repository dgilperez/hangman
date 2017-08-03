defmodule Dictionary do
  def random_word do
    word_list()
    |> Enum.random
  end

  def word_list do
    "assets/lemario-general-del-espanol.txt"
    |> File.read!
    |> String.split(~r/\n/)
  end
end
