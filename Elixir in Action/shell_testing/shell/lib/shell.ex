defmodule Shell do
  import IO
  # Changed the system of code writing a bit,
  # as pasting in big line breaks and comments got a bit too tedious.
  # Also the code wasn't that well readable with those anyway.
  # With this I also make the workflow more time-efficient.

  def maps do
    map1 = %{1 => 1, 2 => 2, 3 => 3}
    # Prepopulating a map
    map2 = Map.new([{1, 1}, {2, 2}, {3, 3}])
    IO.inspect map1
    IO.inspect map2
    puts map1 == map2
    puts ""
    # Fetching a value
    puts map1[2]
    IO.inspect map1[4]
    puts ""
    # If value isn't found, return nil or default value if assigned
    puts Map.get(map1, 4, :not_found)
    puts ""
    # Distinguish a value from and error
    IO.inspect Map.fetch(map1, 2)
    IO.inspect Map.fetch(map1, 4)
    puts ""
    # Add a new key, value pair to map
    map1 = Map.put(map1, 4, 16)
    IO.inspect(map1)
  end
end
