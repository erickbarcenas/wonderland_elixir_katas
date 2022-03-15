defmodule CardGameWar.GameTest do
  use ExUnit.Case
  alias CardGameWar.Game
  alias CardGameWar.Game.Card

  test "the highest rank wins the cards in the round" do
    card1 = %Card{rank: 10, suit: :club}
    card2 = %Card{rank: 7, suit: :spade}
    assert Game.higher_card(card1, card2) == card1
  end

  test "queens are higher rank than jacks" do
    card1 = %Card{rank: :queen, suit: :spade}
    card2 = %Card{rank: :jack, suit: :spade}
    assert Game.higher_card(card1, card2) == card1
  end

  test "kings are higher rank than queens" do
    card1 = %Card{rank: :king, suit: :spade}
    card2 = %Card{rank: :queen, suit: :spade}
    assert Game.higher_card(card1, card2) == card1
  end

  test "aces are higher rank than kings" do
    card1 = %Card{rank: :ace, suit: :spade}
    card2 = %Card{rank: :king, suit: :spade}
    assert Game.higher_card(card1, card2) == card1
  end

  test "if the ranks are equal, clubs beat spades" do
    card1 = %Card{rank: 7, suit: :club}
    card2 = %Card{rank: 7, suit: :spade}
    assert Game.higher_card(card1, card2) == card1
  end

  test "if the ranks are equal, diamonds beat clubs" do
    card1 = %Card{rank: 7, suit: :diamond}
    card2 = %Card{rank: 7, suit: :club}
    assert Game.higher_card(card1, card2) == card1
  end

  test "if the ranks are equal, hearts beat diamonds" do
    card1 = %Card{rank: 7, suit: :heart}
    card2 = %Card{rank: 7, suit: :diamond}
    assert Game.higher_card(card1, card2) == card1
  end

  test "the player loses when they run out of cards" do
    data = [
      %CardGameWar.Game.Card{rank: :ace, suit: :diamond},
      %CardGameWar.Game.Card{rank: 9, suit: :club},
      %CardGameWar.Game.Card{rank: 7, suit: :heart},
      %CardGameWar.Game.Card{rank: :ace, suit: :spade},
      %CardGameWar.Game.Card{rank: :jack, suit: :diamond}]
    assert Game.play_war({data, []}) == ("Player 1 wins!")
    assert Game.play_war({[], data}) == ("Player 2 wins!")
  end

end
