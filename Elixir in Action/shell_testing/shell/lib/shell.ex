defmodule Shell do
  import IO

  def booleans do
    puts "---------------------------------------------------"
    puts ":true == true"
    puts :true == true
    puts "---------------------------------------------------"
    puts ":false == false"
    puts :false == false
    puts "---------------------------------------------------"
    puts "true and false"
    puts true and false
    puts "---------------------------------------------------"
    puts "true or false"
    puts true or false
    puts "---------------------------------------------------"
    puts "not false:"
    puts not false
    puts "---------------------------------------------------"
  end
end
