defmodule FormTest do
  use ExUnit.Case

  test "blanks/1 returns a string with the specified length" do
    assert Form.blanks(5) == "XXXXX"
  end

  # ----------------------------------------------------------------------------

  test "letters/1 returns a list of uppercase letters from the word" do
    assert Form.letters("Hello") == ["H", "E", "L", "L", "O"]
  end

  # ----------------------------------------------------------------------------

  test "check_length/2 returns :ok when the word length is within the limit" do
    assert Form.check_length("Short", 10) == :ok
  end

  test "check_length/2 returns {:error, diff} when the word length exceeds the limit" do
    assert Form.check_length("TooLong", 5) == {:error, 2}
  end

  # ----------------------------------------------------------------------------

  test "format_address/1 formats the address map as an uppercase multiline string" do
    address_map = %{
      street: "123 Main St",
      postal_code: "12345",
      city: "Cityville"
    }
    expected_output = """
    123 MAIN ST
    12345 CITYVILLE
    """
    assert Form.format_address(address_map) == expected_output
  end

  test "format_address/1 formats the address tuple as an uppercase multiline string" do
    address_tuple = {"456 Elm St", "67890", "Townville"}
    expected_output = """
    456 ELM ST
    67890 TOWNVILLE
    """
    assert Form.format_address(address_tuple) == expected_output
  end
end
