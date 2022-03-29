defmodule AlphabetCipher.Coder do

  @alphabet String.graphemes("abcdefghijklmnopqrstuvwxyz")

  @encoding_table Enum.reduce(@alphabet, %{}, fn char, acc ->
    idx = Enum.find_index(@alphabet, &(&1 == char))
    {l1, l2} = Enum.split(@alphabet, idx)
    new_alphabet = l2 ++ l1
    Map.put(acc, char, new_alphabet)
  end)

  def encode(keyword, message) do
    coding_map(keyword, message)
    |> Enum.map(fn {kw_char, msg_char} -> encode_char(kw_char, msg_char) end)
    |> Enum.join()
  end

  def decode(keyword, message) do
    coding_map(keyword, message)
    |> Enum.map(fn {kw_char, msg_char} -> decode_char(kw_char, msg_char) end)
    |> Enum.join()
  end

  defp encode_char(kw_char, msg_char) do
    idx = Enum.find_index(@alphabet, &(&1 == kw_char))
    alphabet = Map.get(@encoding_table, msg_char)
    Enum.at(alphabet, idx)
  end

  defp decode_char(kw_char, msg_char) do
    idx = Enum.find_index(@alphabet, &(&1 == kw_char))
    {k, _v} = Enum.find(@encoding_table, fn {_, v} ->
      Enum.at(v, idx) == msg_char
    end)
    k
  end

  def decipher(ciphered, message) do
    coding_map(ciphered, message)
    |> Enum.map(fn {ciphered_char, msg_char} -> decipher_car(ciphered_char, msg_char) end)
    |> Enum.join()
  end


  defp decipher_car(cipher_char, msg_char) do
    alphabet = Map.get(@encoding_table, msg_char)
    idx = Enum.find(alphabet, &(&1 == cipher_char))
    Enum.at(@alphabet, idx)
  end

  defp coding_map(keyword, message) do
    reps = ceil(String.length(message) / String.length(keyword))
    rep_keyword = String.duplicate(keyword, reps)
    Enum.zip(String.graphemes(rep_keyword), String.graphemes(message))
  end
end
