defmodule CSVSigil do
  @doc """
  Write a `~v` sigil that parses multiple lines of comma-separated data,
  returning a list where each element is a row of data and each row is a list
  of values, Don't worry about quoting--just assume each field is separated
  by a comma.

  ## Example usage

      iex> import LineSeparatedSigil
      nil
      iex> csv = ~v\"""
      ...> 1,2,3
      ...> cat,dog
      ...> \"""
      [[1,2,3],["cat","dog"]]
  """
  def sigil_v(csv, _otps) do
    csv |> String.rstrip |> String.split("\n") |> Enum.map(&String.split(&1, ","))
  end
end

defmodule Example do
  import CSVSigil

  def csv do
    ~v"""
    1,2,3
    cat,dog
    """
  end
end
