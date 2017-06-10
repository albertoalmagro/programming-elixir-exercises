defmodule MyList do
  def caesar(list, n), do: map(list, &(_caesar(&1, n)))

  defp _caesar(actual, n) when actual + n > 122 do
    122
  end
  defp _caesar(actual, n), do: actual + n

  defp map([], _func), do: []
  defp map([head | tail], func), do: [ func.(head) | map(tail, func) ]
end
