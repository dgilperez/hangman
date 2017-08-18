defmodule Dictionary do
  alias Dictionary.WordList

  defdelegate word_list(word_length), to: WordList
  defdelegate random_word, to: WordList
end
