defmodule CardGameWar.Game do

  # feel free to use these cards or use your own data structure"
  defmodule Card do
    defstruct [:suit, :rank]
  end
  # Figures
  def suits, do: [:spade, :club, :diamond, :heart]
  # Card from every figure
  def ranks, do: [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

  # [{:jack, 11}, {:queen, 12}, {:king, 13}, {:king, 14}]

  def cards do
    for suit <- suits(), rank <- ranks() do
      %Card{suit: suit, rank: rank}
    end
    |> Enum.shuffle()
  end


  # reparte cartas
  def deal() do
    players = 2
    cards = cards()
    hand_size = Enum.count(cards) / players |> round()
    cards |> Enum.chunk_every(hand_size)
  end

  defp push(lst, item), do: List.insert_at(lst, 0, item) |> List.flatten()
  # defp pop(lst), do: List.pop_at(lst, 0)



  def game_play() do
    [player1_deck | player2_deck] = deal()
    play_war({player1_deck, player2_deck |> List.flatten})
  end


  def play_war({player1_deck, player2_deck}) do
    case {player1_deck, player2_deck} do
      {_, []} ->
        "Player 1 wins!"
      {[], _} ->
        "Player 2 wins!"
      _ ->
        [p1_card | player1_deck] = player1_deck
        [p2_card | player2_deck] = player2_deck


        #IO.puts("#{p1_card.rank} vs #{p2_card.rank}")

        if higher_card(p1_card, p2_card) == p1_card do
          player1_deck = player1_deck |> push([p1_card, p2_card])
          play_war({player1_deck, player2_deck})
        else
          player2_deck = player2_deck |> push([p1_card, p2_card])
          play_war({player1_deck, player2_deck})
        end
    end
  end


  def get_index(card) do
    Enum.find_index(ranks(), fn rank -> rank == card.rank end)
  end

  def higher_card(p1_card, p2_card) do
    idx1 = get_index(p1_card)
    idx2 = get_index(p2_card)

    cond do
      idx1 > idx2 -> p1_card
      idx2 > idx1 -> p2_card
      true ->
        if Enum.find_index(suits(), fn suit1 -> suit1 == p1_card.suit end) > Enum.find_index(suits(), fn suit2 -> suit2  == p2_card.suit end) do
          p1_card
        else
          p2_card
        end
      end
  end
end
