defmodule Dictionary.WordList do

  # __MODULE__ has "Elixir.Dictionary.WordList" value
  @me __MODULE__

  def start_link do
    Agent.start_link(&word_list/0, name: @me)
  end

  def random_word do
    Agent.get(@me, &Enum.random/1)
    |> normalize_word
  end

  def word_list(word_length) do
    Agent.get(@me, &(&1))
    |> Enum.reject(&(String.length(&1) != word_length))
    |> Enum.map(&(normalize_word(&1)))
    |> Enum.uniq
  end

  def word_list do
    "../../assets/lemario-general-del-espanol.txt"
    |> Path.expand(__DIR__)
    |> File.read!
    |> String.split(~r/\n/)
  end

  #####

  defp normalize_word(word) do
    word
    |> String.normalize(:nfd)
    |> String.replace(~r/[^A-z\s]/u, "")
  end
end
