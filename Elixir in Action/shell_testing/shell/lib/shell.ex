defmodule Shell do
  import IO
  # Changed the system of code writing a bit, as pasting in line breaks got a bit too tedious.
  # Also the code wasn't that well readable with those anyway.
  # With this I also make the workflow more time-efficient.

  def tuples do
    person = {"Robin", 20}
    age = elem(person, 1)
    name = elem(person, 0)

    puts name
    puts age

    person = put_elem(person, 0, "Robin Nook")
    name = elem(person, 0)

    puts " "
    puts name
    puts age
  end
end
