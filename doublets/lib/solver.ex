defmodule Doublets.Solver do
@moduledoc """
  Cuán similares son dos cadenas de caracteres
  Replace `String.levenshtein_distance/2` with `String.jaro_distance/2`

"""
  def words do
    "./resources/words.txt"
      |> File.stream!
      |> Enum.to_list
      |> clean()
  end



  def clean(file) do
    file
    # |> String.normalize(:nfd) # "á" -> "a", "´"
    #|> String.replace(~r/[^A-z\s]/u, "")

    |> Enum.map(fn x->
      String.replace(x, "\n", "")
      |> String.downcase()
      |> String.split(~r/[^[:alnum:]-]/u, trim: true)
     end)
    |> List.flatten()
  end

  def get_valid_type(starting_word, ending_word, row) do
    {et_start, et_end} = get_head_tail(ending_word)

    [left, right] = row #|> IO.inspect()

    {lt_start, lt_end} =  get_head_tail(left)
    {rt_start, rt_end} =  get_head_tail(right)
    cond do
      lt_start == rt_start or lt_end == rt_end ->
        # ok near
        row
      et_start == rt_start or et_end == rt_end ->
        # ok tail
        row
      true ->
        cond do
          left == starting_word -> left
          right == ending_word -> right
          true -> right
        end
    end
  end

  def get_head_tail(current_type) do
    [ct_start | ct_tail] = current_type |> String.graphemes()
    [ct_end | _] = ct_tail |> Enum.reverse()
    {ct_start, ct_end}
  end

  def doublets(starting_word, ending_word) do
    starting_word = starting_word |> String.downcase()
    ending_word = ending_word |> String.downcase()

    len_sw = starting_word |> String.length()
    len_ew = ending_word |> String.length()
    if len_sw != len_ew, do: []

    # Check if the words are in the dictionary
    mini_corpus_indexed =
      words
      |> Enum.filter(fn type -> String.length(type) == String.length(starting_word) end)
      |> Enum.map(fn type -> {type, String.jaro_distance(type, starting_word)} end)
      |> Enum.sort_by(fn tuple -> elem(tuple, 1) end, :desc) # &elem(&1, 1)
      |> Enum.with_index()


    idx_ending_word =
      mini_corpus_indexed
      |> Enum.filter(fn tuple -> elem(tuple, 0) |> elem(0) == ending_word end)

    types_until_ending_word =
      mini_corpus_indexed
      |> Enum.filter(fn tuple -> elem(tuple, 1) <= idx_ending_word
      |> Enum.at(0) |> elem(1) end)
      |> Enum.map(fn tuple -> elem(tuple, 0) |> elem(0) end)

    types_near_to_ending_word =
      types_until_ending_word
      |> Enum.map(fn type -> {type, String.jaro_distance(type, ending_word)} end)
      |> Enum.sort_by(fn tuple -> elem(tuple, 1) end, :asc) # &elem(&1, 1)
      |> Enum.filter(fn tuple -> elem(tuple, 1) > 0.0 end)
      |> Enum.with_index()
      |> Enum.map(fn tuple -> elem(tuple, 0) |> elem(0) end)


    pairs_near_to_ending_word =
      types_near_to_ending_word
      |> Enum.chunk_every( 2, 1, :discard)

    # End type


    response = pairs_near_to_ending_word
    |> Enum.map(fn row ->
      get_valid_type(starting_word, ending_word, row)
    end)
    |> List.flatten()
    |> Enum.uniq()


   end

end
