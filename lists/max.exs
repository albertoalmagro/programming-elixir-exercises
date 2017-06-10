defmodule MyList do
  def max([head | tail]), do: reduce(tail, head, &(_max(&1, &2)))

  # As in the book we haven't still seen if clauses I will use guards.
  defp _max(a, b) when a > b do
    a
  end
  defp _max(_a, b), do: b

  defp reduce([], value, _) do
    value
  end
  defp reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end
end
