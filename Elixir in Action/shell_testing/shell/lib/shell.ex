defmodule Shell do
  import IO
  # Changed the system of code writing a bit,
  # as pasting in big line breaks and comments got a bit too tedious.
  # Also the code wasn't that well readable with those anyway.
  # With this I also make the workflow more time-efficient.

  def strings do
    puts "String"
    puts "Embedded string: #{3 + 0.14}"
    puts "
    Multiline
    String
    ."

    # Sigils
    puts ~s("Hello world!")

    # Heredoc
    puts """
    This is a
    heredoc
    """

    # String concatenation
    puts "Hello" <> " " <> "World!"
  end
end
