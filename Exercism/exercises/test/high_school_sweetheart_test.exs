defmodule HighSchoolSweetheartTest do
  use ExUnit.Case

  test "first_letter/1 it gets the first letter" do
    assert HighSchoolSweetheart.first_letter("Mary") == "M"
  end

  test "first_letter/1 it doesn't change the letter's case" do
    assert HighSchoolSweetheart.first_letter("john") == "j"
  end

  test "first_letter/1 it strips extra whitespace" do
    assert HighSchoolSweetheart.first_letter("\n\t   Sarah   ") == "S"
  end

  # ----------------------------------------------------------------------------

  test "initial/1 it gets the first letter and appends a dot" do
    assert HighSchoolSweetheart.initial("Betty") == "B."
  end

  test "initial/1 it uppercases the first letter" do
    assert HighSchoolSweetheart.initial("james") == "J."
  end

  # ----------------------------------------------------------------------------

  test "initials/1 returns the initials for the first name and the last name" do
    assert HighSchoolSweetheart.initials("Linda Miller") == "L. M."
  end

  # ----------------------------------------------------------------------------

  test "pair/2 prints the pair's initials inside a heart" do
    assert HighSchoolSweetheart.pair("Avery Bryant", "Charlie Dixon") ==
      "     ******       ******\n   **      **   **      **\n **         ** **         **\n**            *            **\n**                         **\n**     A. B.  +  C. D.     **\n **                       **\n   **                   **\n     **               **\n       **           **\n         **       **\n           **   **\n             ***\n              *\n"
  end
end
