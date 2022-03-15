defmodule CardGameWar.Game do

  # feel free to use these cards or use your own data structure"
  defmodule Card do
    defstruct [:suit, :rank]
  end
  # Figures
  def suits, do: [:spade, :club, :diamond, :heart]
  # Card from every figure
  def ranks, do: [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

  def cards do
    for suit <- suits(), rank <- ranks() do
      %Card{suit: suit, rank: rank}
    end
  end


  # reparte cartas
  def cards_deals(num) do
    if num < 1 and num > 5, do: IO.puts(:error)
    cards = cards() |> IO.inspect()
    per_capita = Enum.count(cards) / num |> round()
    cards |> Enum.shuffle() |> Enum.chunk_every(per_capita)
  end

  def compare_values(card1, card2) do
    if card1 == card2 do
      IO.puts("Implementar lógica")
    end

    if card1 > card2 do
      # analizar el tipo de carta del mazo
      # -rey
      # -
      # -
      # retornar
      {
        [ card1 | [card2] ],
        []
      }
    else
      {
        [],
        [ card1 | [card2] ]
      }
    end


  end

  def compare(card1, card2) do
    cond do
      card1 > card2 -> 1
      card1 < card2 -> 2
      true -> 0
    end
  end

  def winner(number) do
    if number == 1 do
      "Player 1 win!"
    else
      "Player 2 win!"
    end
  end


  def game() do
    # para dos jugadores
    cards = cards_deals(2)
    cards_game_1 = cards |> List.first()
    cards_won_1 = []
    cards_game_2 = cards |> List.last()
    cards_won_2 = []

    cards_game_1

    battle = Enum.map(0..25, fn idx ->
      card1 = cards_game_1 |> Enum.at(idx)
      card2 = cards_game_2 |> Enum.at(idx)
      {[card1.rank, card2.rank], compare(card1, card2)}
    end)


    %{player1: Enum.filter(battle, fn {k, v} -> v == 1 end)}

  end
end
