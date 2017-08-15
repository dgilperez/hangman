defmodule Dictionary.WordList do
  def start do
    load_word_list_from_file()
  end

  def start(word_length) do
    start()
    |> Enum.reject(&(String.length(&1) != word_length))
    |> Enum.map(&(normalize_word(&1)))
    |> Enum.uniq
  end

  def random_word(word_list) do
    word_list
    |> Enum.random
    |> normalize_word
  end

  def word_list(word_list) do
    word_list
    |> Enum.map(&(normalize_word(&1)))
    |> Enum.uniq
  end

  #####

  defp load_word_list_from_file do
    "../../assets/lemario-general-del-espanol.txt"
    |> Path.expand(__DIR__)
    |> File.read!
    |> String.split(~r/\n/)
  end

  defp normalize_word(word) do
    word
    |> String.normalize(:nfd)
    |> String.replace(~r/[^A-z\s]/u, "")
  end
end
