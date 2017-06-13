defmodule MyList do
  @moduledoc """
  Write the list flatten function.
  """

  def flatten([]), do: []
  def flatten([ head | tail ]) when is_list(head) do
    flatten(head) ++ flatten(tail)
  end
  def flatten([ head | tail ]) do
    [ head | flatten(tail) ]
  end
end
