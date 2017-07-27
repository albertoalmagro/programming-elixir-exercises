defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: [BitString, List] do
  def encrypt(string, shift) when is_binary(string) do
    String.to_charlist(string)
    |> _encrypt(shift)
  end
  def encrypt(string, shift), do: _encrypt(string, shift)

  defp _encrypt(string, shift) do
    Enum.reduce(string, [], fn x, acc ->
      [(x + shift) | acc]
    end)
    |> Enum.reverse
  end

  @rot13_shift 13
  def rot13(string), do: encrypt(string, @rot13_shift)
end

data = [[65, 66, 67, 68], 'abcd', "abcd"]

IO.puts "encrypt, shift 1"
Enum.each data, fn value ->
  IO.puts Caesar.encrypt(value, 1)
end

IO.puts "encrypt, shift 5"
Enum.each data, fn value ->
  IO.puts Caesar.encrypt(value, 5)
end

IO.puts "rot13"
Enum.each data, fn value ->
  IO.puts Caesar.rot13(value)
end
