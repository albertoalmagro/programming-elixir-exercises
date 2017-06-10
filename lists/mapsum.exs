defmodule MyList do
  def reduce([], value, _) do
    value
  end
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def map([], _func), do: []
  def map([head | tail], func), do: [ func.(head) | map(tail, func) ]

  def mapsum(list, func), do: map(list, func) |> reduce(0, &(&1 + &2))
end
