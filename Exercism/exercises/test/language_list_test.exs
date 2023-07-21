defmodule LanguageListTest do
  use ExUnit.Case

  test "new/0 new list" do
    assert LanguageList.new() == []
  end

  # ----------------------------------------------------------------------------

  test "add/2 add a language to a list" do
    language = "Elixir"
    list = [language]
    assert LanguageList.new()
    |> LanguageList.add(language) == list
  end

  test "add/2 add several languages to a list" do
    list =
      LanguageList.new()
      |> LanguageList.add("Clojure")
      |> LanguageList.add("Haskell")
      |> LanguageList.add("Erlang")
      |> LanguageList.add("F#")
      |> LanguageList.add("Elixir")

    assert list == ["Elixir", "F#", "Erlang", "Haskell", "Clojure"]
  end

  # ----------------------------------------------------------------------------

  test "remove/1 add then remove results in empty list" do
    list = LanguageList.new()
    |> LanguageList.add("Elixir")
    |> LanguageList.remove()
    assert list == []
  end

  test "remove/1 adding two languages, when removed, removes first item" do
    list =
      LanguageList.new()
      |> LanguageList.add("F#")
      |> LanguageList.add("Elixir")
      |> LanguageList.remove()

    assert list == ["F#"]
  end

  # ----------------------------------------------------------------------------

  test "first/1 add one language, then get the first" do
    assert LanguageList.new()
    |> LanguageList.add("Elixir")
    |> LanguageList.first() == "Elixir"
  end

  test "first/1 add a few languages, then get the first" do
    first =
      LanguageList.new()
      |> LanguageList.add("Elixir")
      |> LanguageList.add("Prolog")
      |> LanguageList.add("F#")
      |> LanguageList.first()

    assert first == "F#"
  end

  # ----------------------------------------------------------------------------

  test "count/1 the count of a new list is 0" do
    assert LanguageList.new() |> LanguageList.count() == 0
  end

  test "count/1 the count of a one-language list is 1" do
    count = LanguageList.new() |> LanguageList.add("Elixir") |> LanguageList.count()
    assert count == 1
  end

  test "count/1 the count of a multiple-item list is equal to its length" do
    count =
      LanguageList.new()
      |> LanguageList.add("Elixir")
      |> LanguageList.add("Prolog")
      |> LanguageList.add("F#")
      |> LanguageList.count()

    assert count == 3
  end

  # ----------------------------------------------------------------------------

  test "functional_list?/1 a functional language list" do
    assert LanguageList.functional_list?(["Clojure", "Haskell", "Erlang", "F#", "Elixir"])
  end

  test "functional_list?/1 not a functional language list" do
    refute LanguageList.functional_list?(["Java", "C", "JavaScript"])
  end
end
