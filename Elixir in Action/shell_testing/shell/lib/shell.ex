defmodule Shell do
  import IO
  # Changed the system of code writing a bit,
  # as pasting in big line breaks and comments got a bit too tedious.
  # Also the code wasn't that well readable with those anyway.
  # With this I also make the workflow more time-efficient.

  def maps_with_atom_keys do
    # When the keys are atoms, you can construct a map in a more simple and cleaner manner.
    person = %{:name => "Robin", :age => 20, :works_at => "Yolo"}
    person = %{name: "Robin", age: 20, works_at: "Yolo"}
    IO.inspect(person)
    puts ""
    # Again atoms get special syntax treatment
    puts person[:name]
    puts person.name
    puts ""
    # Changing data in maps
    IO.inspect(%{person | age: 30, works_at: "Home"})
  end
end
