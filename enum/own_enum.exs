defmodule OwnEnum do
  @moduledoc """
  Implement the Enum functions all?, each, filter, and take without using library
  functions or list comprehensions.
  """

  def all?(enumerable, fun \\ fn x -> x end)

  def all?([], _), do: true
  def all?([ head | tail ], fun) do
    if fun.(head) do
      all?(tail, fun)
    else
      false
    end
  end

  def each([], _fun), do: []
  def each([ head | tail ], fun), do: [ fun.(head) | each(tail, fun) ]

  def filter([], _fund), do: []
  def filter([ head | tail ], fun) do
    if fun.(head) do
      [ head | filter(tail, fun) ]
    else
      filter(tail, fun)
    end
  end

  def split([], _), do: {[], []}
  def split(enumerable, 0), do: {[], enumerable}
  def split(enumerable, count) do
    left = enumerable |> take(count)
    { left, enumerable -- left}
  end

  def take([], _), do: []
  def take(enumerable, count), do: _take(enumerable, count, 0)

  defp _take([ head |tail ], count, actual) when actual < count do
    [ head | _take(tail, count, actual + 1) ]
  end
  defp _take(_, _, _) do
    []
  end
end
