defmodule Dictionary do
  alias Dictionary.WordList

  defdelegate start, to: WordList
  defdelegate start(word_length), to: WordList
  defdelegate random_word(word_list), to: WordList
end
