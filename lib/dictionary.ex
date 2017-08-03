defmodule Dictionary do
  def random_word do
    Enum.random(word_list())
  end

  def word_list do
    contents = File.read!("assets/lemario-general-del-espanol.txt")
    String.split(contents, ~r/\n/)
  end
end
