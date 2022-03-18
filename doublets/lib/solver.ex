defmodule Doublets.Solver do
@moduledoc """
  Cuán similares son dos cadenas de caracteres
  Replace `String.levenshtein_distance/2` with `String.jaro_distance/2`

"""
  def words do
    "./resources/words.txt"
      |> File.stream!
      |> Enum.to_list
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

  def doublets(starting_word, ending_word) do
    starting_word = starting_word |> String.downcase()
    ending_word = ending_word |> String.downcase()

    len_sw = starting_word |> String.length()
    len_ew = ending_word |> String.length()
    if len_sw != len_ew, do: IO.inspect({:error, "Words aren't the same lengths"})

    # Check if the words are in the dictionary
    mini_corpus_indexed =
      words
      |> clean()
      |> Enum.filter(fn type -> String.length(type) == String.length(starting_word) end)
      |> Enum.map(fn type -> {type, String.jaro_distance(type, starting_word)} end)
      |> Enum.sort_by(fn tuple -> elem(tuple, 1) end, :desc) # &elem(&1, 1)
      |> Enum.with_index()


    goal =
      mini_corpus_indexed
      |> Enum.filter(fn tuple -> elem(tuple, 0) |> elem(0) == ending_word end)

    response =
      mini_corpus_indexed
      |> Enum.filter(fn tuple -> elem(tuple, 1) <= goal
      |> Enum.at(0) |> elem(1) end)
      |> Enum.map(fn tuple -> elem(tuple, 0) |> elem(0) end)

    response

   end

end
