defmodule Doublets.Solver do

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
    words
    |> clean()

  end

end
