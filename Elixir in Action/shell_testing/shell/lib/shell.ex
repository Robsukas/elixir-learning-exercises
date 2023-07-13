defmodule Shell do
  import IO
  # Changed the system of code writing a bit,
  # as pasting in big line breaks and comments got a bit too tedious.
  # Also the code wasn't that well readable with those anyway.
  # With this I also make the workflow more time-efficient.

  def character_list do
    puts 'ABC'
    puts [65, 66, 67]
    string = "String"
    charlist = String.to_charlist(string)
    puts string == charlist

  end
end
