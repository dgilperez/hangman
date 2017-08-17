defmodule Dictionary.WordList do
  def random_word(word_list) do
    word_list
    |> Enum.random
    |> normalize_word
  end

  def word_list do
    "../../assets/lemario-general-del-espanol.txt"
    |> Path.expand(__DIR__)
    |> File.read!
    |> String.split(~r/\n/)
  end

  def word_list(word_length) do
    word_list()
    |> Enum.reject(&(String.length(&1) != word_length))
    |> Enum.map(&(normalize_word(&1)))
    |> Enum.uniq
  end

  #####

  defp normalize_word(word) do
    word
    |> String.normalize(:nfd)
    |> String.replace(~r/[^A-z\s]/u, "")
  end
end
