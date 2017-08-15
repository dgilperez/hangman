defmodule GameWorkbench.Guesser do
  alias TextClient.State

  def guess_move(game = %State{ tally: tally }) do
    Map.put(game, :guess, guess_letter(tally))
  end

  ######

  defp guess_letter(tally = %{ letters_used: letters_used }) do
    possible_letters(tally) -- Enum.uniq(letters_used)
    |> List.first
  end

  # Different strategies for finding the next letter:
  # - Sorted alphabet
  # - Random alphabet
  # - Frequency-sorted alphabet
  # - Possible words
  # - Frequency-sorted from possible words
  defp possible_letters(tally) do
    # alphabet()
    # alphabet_random()
    # alphabet_by_frequency_in_spanish()
    # alphabet_by_existing_words(tally)
    most_probable_alphabet_by_existing_words(tally)
  end

  def most_probable_alphabet_by_existing_words(tally) do
    letters_in_existing_words = alphabet_by_existing_words(tally)
    alphabet_by_frequency_in_spanish()
    |> Enum.filter(&(&1 in letters_in_existing_words))
  end

  def alphabet_by_existing_words(%{ letters: letters, letters_used: letters_used }) do
    possible_words(Enum.join(letters), letters_used)
    |> List.flatten
    |> Enum.join
    |> String.downcase
    |> String.codepoints
    |> Enum.uniq
  end

  def possible_words(word_so_far, letters_used) do
    words_by_matches_count = Dictionary.word_list(String.length(word_so_far))
    |> Enum.reduce(%{}, fn(word, acc) ->
                         matches_count = String.myers_difference(word_so_far, word)
                                         |> Enum.reduce(0, fn({key, substring}, matches) ->
                                              cond do
                                                key == :eq ->
                                                  matches + String.length(substring)
                                                true ->
                                                  matches
                                              end
                                            end)
                         cond do
                           # all letters already tried, discard
                           Enum.uniq(String.codepoints(word)) -- letters_used == [] ->
                             acc
                           # there is a word with more matches already in the list, discard
                           Map.has_key?(acc, matches_count + 1) ->
                             acc
                           true ->
                             Map.put(acc, matches_count, Enum.into(Map.get(acc, matches_count) || [], [word]))
                         end
                       end)

    max_matches_count = Enum.max(Map.keys(words_by_matches_count))
    words_by_matches_count[max_matches_count]
  end

  # 26.9 - 27.6% in 1_000 iterations
  def alphabet_by_frequency_in_spanish do
    String.codepoints "eaosrnidlctumpbgvyqhfzjxkw"
  end

  # 0.1 - 0.3 - 0.5 - 1.1% in 1_000 iterations
  defp alphabet_random do
    for n <- ?a..?z, do: << n :: utf8 >>
    |> Enum.shuffle
  end

  defp alphabet do
    for n <- ?a..?z, do: << n :: utf8 >>
  end
end
