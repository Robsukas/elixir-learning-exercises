defmodule RPGTest do
  use ExUnit.Case

  test "Edible is a protocol" do
    assert RPG.Edible.__protocol__(:functions) == [eat: 2]
  end



  test "LoafOfBread eating it increases health" do
    character = %RPG.Character{health: 50}
    {_byproduct, %RPG.Character{} = character} = RPG.Edible.eat(%RPG.LoafOfBread{}, character)
    assert character.health == 55
  end

  test "LoafOfBread eating it has no byproduct" do
    character = %RPG.Character{}
    {byproduct, %RPG.Character{}} = RPG.Edible.eat(%RPG.LoafOfBread{}, character)
    assert byproduct == nil
  end

  test "LoafOfBread eating it does not affect mana" do
    character = %RPG.Character{mana: 77}
    {_byproduct, %RPG.Character{} = character} = RPG.Edible.eat(%RPG.LoafOfBread{}, character)
    assert character.mana == 77
  end



  test "ManaPotion eating it increases mana" do
    character = %RPG.Character{mana: 10}
    {_byproduct, %RPG.Character{} = character} = RPG.Edible.eat(%RPG.ManaPotion{strength: 6}, character)
    assert character.mana == 16
    {_byproduct, %RPG.Character{} = character} = RPG.Edible.eat(%RPG.ManaPotion{strength: 9}, character)
    assert character.mana == 25
  end

  test "ManaPotion eating it produces an empty bottle" do
    character = %RPG.Character{}
    {byproduct, %RPG.Character{}} = RPG.Edible.eat(%RPG.ManaPotion{}, character)
    assert byproduct == %RPG.EmptyBottle{}
  end

  test "ManaPotion eating it does not affect health" do
    character = %RPG.Character{health: 4}
    {_byproduct, %RPG.Character{} = character} = RPG.Edible.eat(%RPG.ManaPotion{strength: 6}, character)
    assert character.health == 4
  end



  test "Poison eating it brings health down to 0" do
    character = %RPG.Character{health: 120}
    {_byproduct, %RPG.Character{} = character} = RPG.Edible.eat(%RPG.Poison{}, character)
    assert character.health == 0
  end

  test "Poison eating it produces an empty bottle" do
    character = %RPG.Character{}
    {byproduct, %RPG.Character{}} = RPG.Edible.eat(%RPG.Poison{}, character)
    assert byproduct == %RPG.EmptyBottle{}
  end

  test "Poison eating it does not affect mana" do
    character = %RPG.Character{mana: 99}
    {_byproduct, %RPG.Character{} = character} = RPG.Edible.eat(%RPG.Poison{}, character)
    assert character.mana == 99
  end

  test "eating many things one after another" do
    items = [%RPG.LoafOfBread{}, %RPG.ManaPotion{strength: 10}, %RPG.ManaPotion{strength: 2}, %RPG.LoafOfBread{}]
    character = %RPG.Character{health: 100, mana: 100}

    character =
      Enum.reduce(items, character, fn item, character ->
        {_, character} = RPG.Edible.eat(item, character)
        character
      end)

    assert character.health == 110
    assert character.mana == 112
  end
end
