defmodule Shell do
  import IO

  def numbers do
    puts "---------------------------------------------------"
    puts "Integer"
    puts 17
    puts "---------------------------------------------------"
    puts "Integer written in HEX"
    puts 0xEF
    puts "---------------------------------------------------"
    puts "Float"
    puts 9.8
    puts "---------------------------------------------------"
    puts "Float with exponential notation"
    puts 99.0e-5
    puts "---------------------------------------------------"
  end

  def arithmetic do
    puts "---------------------------------------------------"
    puts "Returns an integer (5 + 3 * 10)"
    puts 5 + 3 * 10
    puts "---------------------------------------------------"
    puts "Always returns a float (10 / 5)"
    puts 10 / 5
    puts "---------------------------------------------------"
    puts "Integer division (4 // 2)"
    puts div(4, 2)
    puts "---------------------------------------------------"
    puts "Integer remainder (35 % 3)"
    puts rem(35, 3)
    puts "---------------------------------------------------"
  end
end
