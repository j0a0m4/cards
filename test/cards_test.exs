defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_decks makes 52 cards" do
    deck = Cards.create_deck
    assert length(deck) == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    refute Cards.shuffle(deck) == Cards.shuffle(deck)
  end

  test "dealing returns a hand and the remainder of cards" do
    {hand, deck} = Cards.create_deck |> Cards.deal(2)
    assert hand == [hearts: :two, hearts: :three]
    assert deck |> Enum.take(1) == [hearts: :four]
    assert length(deck) == 50
  end

  test "create_hand composes create_deck, shuffle and deal" do
    {hand, deck} = Cards.create_hand 7
    assert length(hand) == 7
    assert length(deck) == 45
  end
end
