defmodule Shell do
  alias IO, as: NewIO

  # Using the new alias for the IO module.
  def fun do
    NewIO.puts "Hi!"
  end
end
