defmodule AlphabetCipher.Coder do

  def gen_matrix() do
    alphabet_cols = %{
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

    alphabet_rows = %{
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

  def repeat_message(msg) do
    desire_len = 29
    msg_len = String.length(msg)
    String.duplicate(msg, msg_len * Float.round(desire_len / msg_len, 0) |> trunc())
    |> String.slice(0..desire_len - 1)
  end

  def encode(keyword, message) do
    msg = String.downcase(message) |> String.split() |> Enum.join("")

    if Enum.count(msg) > 0 do
      repeat_message(msg)
    else
      IO.puts('Por favor ingrese un texto')
    end

  end

  def decode(keyword, message) do
    "decodeme"
  end

  def decipher(cipher, message) do
    "decypherme"
  end
end
