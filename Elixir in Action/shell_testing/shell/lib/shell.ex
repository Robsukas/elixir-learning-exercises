defmodule Shell do
  # Private and public function calls.
  def double(a) do
    add_priv(a, a)
  end

  # Can't directly call this from the iex.
  defp add_priv(a, b) do
    a + b
  end
end
