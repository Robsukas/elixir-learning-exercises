defmodule Shell do
  import IO
  # Changed the system of code writing a bit,
  # as pasting in big line breaks and comments got a bit too tedious.
  # Also the code wasn't that well readable with those anyway.
  # With this I also make the workflow more time-efficient.

  def lists do
    # Most operations on lists have an O(n) complexity.
    numbers = [1, 2, 3, 4]
    IO.puts length(numbers)
    IO.inspect numbers
    IO.puts " "
    IO.puts Enum.at(numbers, 0)
    IO.puts " "
    IO.puts 5 in numbers
    IO.puts 3 in numbers
    IO.puts " "
    numbers = List.replace_at(numbers, 0, 10)
    IO.inspect numbers
    IO.puts " "
    numbers = List.insert_at(numbers, -1, 0)
    IO.inspect numbers
    IO.puts " "
    numbers2 = [11, 14]
    IO.inspect numbers ++ numbers2
    IO.puts " "
  end
end
