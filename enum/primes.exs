defmodule Primes do
  def up_to(n), do: for x <- span(2, n), rem(x, 2) == 1, prime?(x), do: x

  def prime?(2), do: true
  def prime?(n), do: Enum.all?(span(2, n - 1), &(rem(n, &1) !== 0))

  defp span(a, a), do: [ a ]
  defp span(from, to) when from < to do
    [ from | span(from + 1, to) ]
  end
  defp span(from, to) when from > to do
    raise "from can't be higher than to!"
  end
end
