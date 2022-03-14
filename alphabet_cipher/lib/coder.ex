defmodule AlphabetCipher.Coder do

  def alphabet_cols() do
    %{
      a: 0,
      b: 1,
      c: 2,
      d: 3,
      e: 4,
      f: 5,
      g: 6,
      h: 7,
      i: 8,
      j: 9,
      k: 10,
      l: 11,
      m: 12,
      n: 13,
      o: 14,
      p: 15,
      q: 16,
      r: 17,
      s: 18,
      t: 19,
      u: 20,
      v: 21,
      w: 22,
      x: 23,
      y: 24,
      z: 25
    }
  end

  def alphabet_rows() do
    %{
      a: String.graphemes("abcdefghijklmnopqrstuvwxyz"),
      b: String.graphemes("bcdefghijklmnopqrstuvwxyza"),
      c: String.graphemes("cdefghijklmnopqrstuvwxyzab"),
      d: String.graphemes("defghijklmnopqrstuvwxyzabc"),
      e: String.graphemes("efghijklmnopqrstuvwxyzabcd"),
      f: String.graphemes("fghijklmnopqrstuvwxyzabcde"),
      g: String.graphemes("ghijklmnopqrstuvwxyzabcdef"),
      h: String.graphemes("hijklmnopqrstuvwxyzabcdefg"),
      i: String.graphemes("ijklmnopqrstuvwxyzabcdefgh"),
      j: String.graphemes("jklmnopqrstuvwxyzabcdefghi"),
      k: String.graphemes("klmnopqrstuvwxyzabcdefghij"),
      l: String.graphemes("lmnopqrstuvwxyzabcdefghijk"),
      m: String.graphemes("mnopqrstuvwxyzabcdefghijkl"),
      n: String.graphemes("nopqrstuvwxyzabcdefghijklm"),
      o: String.graphemes("opqrstuvwxyzabcdefghijklmn"),
      p: String.graphemes("pqrstuvwxyzabcdefghijklmno"),
      q: String.graphemes("qrstuvwxyzabcdefghijklmnop"),
      r: String.graphemes("rstuvwxyzabcdefghijklmnopq"),
      s: String.graphemes("stuvwxyzabcdefghijklmnopqr"),
      t: String.graphemes("tuvwxyzabcdefghijklmnopqrs"),
      u: String.graphemes("uvwxyzabcdefghijklmnopqrst"),
      v: String.graphemes("vwxyzabcdefghijklmnopqrstu"),
      w: String.graphemes("wxyzabcdefghijklmnopqrstuv"),
      x: String.graphemes("xyzabcdefghijklmnopqrstuvw"),
      y: String.graphemes("yzabcdefghijklmnopqrstuvwx"),
      z: String.graphemes("zabcdefghijklmnopqrstuvwxy")
    }
  end

  def repeat_str(key_joined, msg_joined) do
    new_key_desire_len = String.length(msg_joined)
    current_key_len = String.length(key_joined)

    String.duplicate(key_joined, new_key_desire_len * Float.round(new_key_desire_len / current_key_len, 0) |> trunc())
    |> String.slice(0..new_key_desire_len - 1)
  end

  def str_joined(str) do
    String.downcase(str) |> String.split() |> Enum.join("")
  end

  def create_map(str) do
    str
    |> String.split()
    |> Map.new(fn k -> {k, ''} end)
  end

  def create_data(keyword, message) do
    # convierto a lista y después uno los textos
    key_joined = str_joined(keyword)
    msg_joined = str_joined(message)

    if String.length(key_joined) < 0 do
      IO.puts("Por favor ingrese una clave")
    end

    if String.length(msg_joined) < 0 do
      IO.puts("Por favor ingrese un mensaje")
    end

    # Dependiendo de la longitud del mensaje
    # se crea la repetición de la keyword con
    # la misma longitud que el mensaje
    key_repeated = repeat_str(key_joined, msg_joined)


    if String.length(key_repeated) != String.length(msg_joined) do
      IO.puts('Error')
    end

      # Ahora se debe crear un mapa donde la llave es cada letra de
      # la palabra clave y el valor cada letra del mensaje
      list_key_repeated = key_repeated |> String.graphemes()
      list_msg = msg_joined |> String.graphemes()
      data = Enum.zip(list_key_repeated, list_msg)
  end

  def encode(keyword, message) do
      data = create_data(keyword, message)

      encode_message =
      data
      |> Enum.with_index
      |> Enum.map(fn({current_tuple, index}) ->

          #current_tuple = data |> Enum.at(index)
          ct_first = elem(current_tuple, 0)
          ct_second = elem(current_tuple, 1)

          row = alphabet_rows[String.to_atom(ct_first)]
          col = alphabet_cols[String.to_atom(ct_second)]
          row |> Enum.at(col) # new_letter
      end)
        #IO.puts("---------------------------------------------")
        #IO.puts("The encoded message is now #{encode_message}")
      encode_message |> Enum.join("")
  end

  def decode(keyword, message) do
    data = create_data(keyword, message)
    
    decode_message =
      data
      |> Enum.with_index
      |> Enum.map(fn({current_tuple, index}) ->
        ct_first = elem(current_tuple, 0)
        ct_second = elem(current_tuple, 1)

        row = alphabet_rows[String.to_atom(ct_first)]
        idx_col = Enum.find_index(row, fn x ->  x == ct_second end)

        letter_col = alphabet_cols() |> Enum.find(fn {_, val} -> val == idx_col end) |> elem(0)
        Atom.to_string(letter_col)
      end)
    decode_message |> Enum.join("")
  end

  def decipher(cipher, message) do
    "decypherme"
  end
end
