defmodule MyList do
  def mapsum(list, func), do: map(list, func) |> reduce(0, &(&1 + &2))

  defp reduce([], value, _) do
    value
  end
  defp reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  defp map([], _func), do: []
  defp map([head | tail], func), do: [ func.(head) | map(tail, func) ]
end
