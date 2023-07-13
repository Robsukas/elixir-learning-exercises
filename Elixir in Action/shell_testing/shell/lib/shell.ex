defmodule Shell do
  import IO

  def atoms do
    puts "---------------------------------------------------"
    puts "Atoms"
    puts :atom
    puts :another_atom
    puts :"an atom with spaces"
    puts "---------------------------------------------------"
    puts "Atoms are used for naming constants"
    puts variable = :variable
    puts "---------------------------------------------------"
  end
end
