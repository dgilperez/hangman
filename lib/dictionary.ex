defmodule Dictionary do
  def random_word do
    word_list()
    |> Enum.random
    |> normalize_word
  end

  def random_word(word_length) do
    word_list(word_length)
    |> Enum.random
  end

  def word_list do
    load_word_list_from_file()
  end

  def word_list(word_length) do
    load_word_list_from_file()
    |> Enum.map(fn(word) -> normalize_word(word) end)
    |> Enum.reject(fn(x) -> String.length(x) != word_length end)
    |> Enum.uniq
  end

  #####

  defp load_word_list_from_file do
    "../assets/lemario-general-del-espanol.txt"
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
