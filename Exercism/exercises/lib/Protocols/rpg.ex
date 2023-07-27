defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_item, character) do
      {nil, %{character | health: character.health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(item, character) do
      {%EmptyBottle{}, %{character | mana: character.mana + item.strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_item, character) do
      {%EmptyBottle{}, %{character | health: 0}}
    end
  end
end
