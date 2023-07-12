defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards.
  """

  @spec create_deck :: list
  @doc """
  Provides a list of playing cards as String with the following ruleset: "{value} of {suit}".
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @spec shuffle(any) :: list
  @doc """
  Given a deck of cards, shuffle it.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @spec contains?(any, any) :: boolean
  @doc """
  Given a deck of cards and a specific card, checks if the deck of cards contains the card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @spec deal(any, integer) :: {list, list}
  @doc """
  Given a deck of cards and a size of the hand, deal a hand.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @spec save(
          any,
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: :ok | {:error, atom}
  @doc """
  Given a deck of cards and a filename, save the deck of cards as binary to the file.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @spec load(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: any
  @doc """
  Given a filename, read out the contents of the file.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist!"
    end
  end

  @spec create_hand(integer) :: {list, list}
  @doc """
  Given a hand size, generate a deck of cards, shuffle it and then deal a hand with the given size.
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
