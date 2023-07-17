defmodule RulesTest do
  use ExUnit.Case

  test "eat_ghost?/2 ghost gets eaten" do
    assert Rules.eat_ghost?(true, true)
  end

  test "eat_ghost?/2 ghost does not get eaten because no power pellet active" do
    refute Rules.eat_ghost?(false, true)
  end

  test "eat_ghost?/2 ghost does not get eaten because not touching ghost" do
    refute Rules.eat_ghost?(true, false)
  end

  test "eat_ghost?/2 ghost does not get eaten because no power pellet is active, even if not touching ghost" do
    refute Rules.eat_ghost?(false, false)
  end

  test "score?/2 score when eating dot" do
    assert Rules.score?(false, true)
  end

  test "score?/2 score when eating power pellet" do
    assert Rules.score?(true, false)
  end

  test "score?/2 no score when nothing eaten" do
    refute Rules.score?(false, false)
  end

  test "lose?/2 lose if touching a ghost without a power pellet active" do
    assert Rules.lose?(false, true)
  end

  test "lose?/2 don't lose if touching a ghost with a power pellet active" do
    refute Rules.lose?(true, true)
  end

  test "lose?/2 don't lose if not touching a ghost" do
    refute Rules.lose?(true, false)
  end

  test "win?/3 win if all dots eaten" do
    assert Rules.win?(true, false, false)
  end

  test "win?/3 don't win if all dots eaten, but touching a ghost" do
    refute Rules.win?(true, false, true)
  end

  test "win?/3 win if all dots eaten and touching a ghost with a power pellet active" do
    assert Rules.win?(true, true, true)
  end
end
