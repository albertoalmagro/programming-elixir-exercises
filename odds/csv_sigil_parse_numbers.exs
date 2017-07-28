defmodule CSVSigil do
  @doc """
  Write a `~v` sigil that parses multiple lines of comma-separated data,
  returning a list where each element is a row of data and each row is a list
  of values, Don't worry about quoting--just assume each field is separated
  by a comma. Numbers conversion is supported on this version.

  ## Example usage

      iex> import LineSeparatedSigil
      nil
      iex> csv = ~v\"""
      ...> 1,2,3.14
      ...> cat,dog
      ...> \"""
      [[1.0,2.0,3.14],["cat","dog"]]
  """
  def sigil_v(csv, _otps) do
    csv
    |> String.rstrip
    |> String.split("\n")
    |> Enum.map(fn line -> _parse_line(line) end)
  end

  defp _parse_line(line) do
    line |> String.split(",") |> Enum.map(fn item -> _parse_float(item) end)
  end

  defp _parse_float(value) do
    case Float.parse(value) do
      { float, _ } -> float
      :error       -> value
    end
  end
end

defmodule Example do
  import CSVSigil

  def csv do
    ~v"""
    1,2,3.14
    cat,dog
    """
  end
end
