defmodule Dictionary do
  def random_word do
    word_list()
    |> Enum.random
    |> String.normalize(:nfd)
    |> String.replace(~r/[^A-z\s]/u, "")
  end

  def word_list do
    "../assets/lemario-general-del-espanol.txt"
    |> Path.expand(__DIR__)
    |> File.read!
    |> String.split(~r/\n/)
  end
end
