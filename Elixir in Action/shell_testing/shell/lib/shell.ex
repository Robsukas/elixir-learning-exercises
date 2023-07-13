defmodule Shell do
  alias IO, as: NewIO
  alias Shell.Second # Second is used as alias

  # Using the new alias for the IO module.
  def fun do
    NewIO.puts "Hi!"
    Second.fun()
  end
end


defmodule Shell.Second do
  def fun do
    2 + 2
  end
end
