defmodule Bitmap do
  defstruct value: 0

  @doc """
  A simple accessor for the 2^bit value in an integer

    iex> b = %Bitmap{value: 5}
    %Bitmap{value: 5}
    iex> Bitmap.fetch_bit(b,2)
    1
    iex> Bitmap.fetch_bit(b,1)
    0
    iex> Bitmap.fetch_bit(b,0)
    1
  """
  def fetch_bit(%Bitmap{value: value}, bit) do
    use Bitwise

    (value >>> bit) &&& 1
  end
end

defimpl Collectable, for: Bitmap do
  use Bitwise

  def into(%Bitmap{value: target}) do
    {
      target,
      fn
        acc, {:cont, next_bit} -> (acc <<< 1) ||| next_bit
        acc,  :done            -> %Bitmap{value: acc}
        _, :halt               -> :ok
      end
    }
  end
end
