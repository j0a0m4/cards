defmodule Cards do
  @moduledoc """
    Provides functions for creating and handling a deck of cards
  """
  @doc """
    Creates a deck of 52 cards
  ## Example
        iex> deck = Cards.create_deck
        iex> [first] = deck |> Enum.take(1)
        iex> first
        {:hearts, :two}
  """
  def create_deck do
    suits = [:hearts, :diamonds, :spades, :clubs]

    faces = [
      :two,
      :three,
      :four,
      :five,
      :six,
      :seven,
      :eight,
      :nine,
      :ten,
      :jack,
      :queen,
      :king,
      :ace
    ]

    for suit <- suits, face <- faces do
      {suit, face}
    end
  end

  @doc """
    Shuffles a given deck

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.shuffle(deck)
  """
  def shuffle(deck) do
    deck |> Enum.shuffle()
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates the amount of cards

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 3)
      iex> hand
      [hearts: :two, hearts: :three, hearts: :four]
  """
  def deal(deck, hand_size) do
    deck |> Enum.split(hand_size)
  end

  @doc """
    Creates a deck, shuffles it and then divides it into a hand and the remainder of the deck.
    It's the function composition of `Cards.create_deck`, `Cards.shuffle` and `Cards.deal`.
    The `hand_size` argument indicates the amount of cards.

  ## Examples
      iex> {hand, deck} = Cards.create_hand(5)
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

  @doc """
    Determines wheter a deck contains a given card
  ## Examples
        iex> deck = Cards.create_deck
        iex> card = {:hearts, :two}
        iex> Cards.contains?(deck, card)
        true
  """
  def contains?(deck, card) do
    deck |> Enum.member?(card)
  end

  @doc """
    Writes the given deck into disk.
    The `filename` argument indicates the path to save the file
  """
  def save(deck, filename) do
    filename
    |> File.write(deck |> :erlang.term_to_binary())
  end

  @doc """
    Reads the given deck from disk.
    The `filename` argument indicates the path to read the file
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> binary |> :erlang.binary_to_term()
      {:error, _} -> "That file does not exist"
    end
  end

end
