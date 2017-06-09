defmodule Chop do
  def guess(actual, a..b) do
    guess = div(a + b, 2)
    IO.puts "Is it #{guess}"
    check(actual, a..b, guess)
  end

  defp check(actual, _, guess) when guess == actual do
    IO.puts guess
  end

  defp check(actual, _..b, guess) when actual > guess do
    guess(actual, (guess + 1)..b)
  end

  defp check(actual, a.._, guess) when actual < guess do
    guess(actual, a..(guess - 1))
  end
end
