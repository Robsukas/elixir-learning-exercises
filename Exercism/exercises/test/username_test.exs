defmodule UsernameTest do
  use ExUnit.Case

  test "sanitize/1 works for an empty charlist" do
    assert Username.sanitize(~c"") == ~c""
  end

  test "sanitize/1 it allows lowercase Latin letters" do
    assert Username.sanitize(~c"anne") == ~c"anne"
  end

  test "sanitize/1 it allows the whole lowercase Latin alphabet" do
    lowercase_latin_letters = ~c"abcdefghijklmnopqrstuvwxyz"
  assert Username.sanitize(lowercase_latin_letters) == lowercase_latin_letters
  end

  test "sanitize/1 it removes numbers" do
    assert Username.sanitize(~c"schmidt1985") == ~c"schmidt"
  end

  test "sanitize/1 it removes punctuation" do
    assert Username.sanitize(~c"*fritz*!$%") == ~c"fritz"
  end

  test "sanitize/1 it removes whitespace" do
    assert Username.sanitize(~c" olaf ") == ~c"olaf"
  end

  test "sanitize/1 it removes all disallowed characters" do
    allowed_characters = ~c"abcdefghijklmnopqrstuvwxyz_ßäöü"
    input = Enum.to_list(0..1_114_111) -- allowed_characters
    assert Username.sanitize(input) == ~c""
  end

  # ----------------------------------------------------------------------------

  test "sanitize/1 it allows underscores" do
    assert Username.sanitize(~c"marcel_huber") == ~c"marcel_huber"
  end

  # ----------------------------------------------------------------------------

  test "sanitize/1 it substitutes German letters" do
    assert Username.sanitize(~c"krüger") == ~c"krueger"
    assert Username.sanitize(~c"köhler") == ~c"koehler"
    assert Username.sanitize(~c"jäger") == ~c"jaeger"
    assert Username.sanitize(~c"groß") == ~c"gross"
  end
end
