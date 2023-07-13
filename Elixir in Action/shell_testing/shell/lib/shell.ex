defmodule Shell do
  import IO

  def truthy_and_falsy_values do
    puts "---------------------------------------------------"
    puts "nil and false are both considered falsy values, all other values are considered truthy"
    puts "|| operator returns first operator that isn't falsy (nil || false || 10 || true)"
    puts (nil || false || 10 || true)
    puts "---------------------------------------------------"
    puts "When all values are falsy, the || operator returns the last given value (nil || false)"
    puts (nil || false)
    puts "---------------------------------------------------"
    puts "&& operator returns the second given value only if the first one is truthy (:an_atom && 5)"
    puts (:an_atom && 5)
    puts "---------------------------------------------------"
    puts "When the first given value is falsy, the first given value is returned instead (false && true)"
    puts (false && true)
    puts "---------------------------------------------------"
  end
end
