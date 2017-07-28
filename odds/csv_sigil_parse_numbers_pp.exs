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
      iex> csv = ~v\"""
      ...> Item,Qty,Price
      ...> Teddy bear,4,34.95
      ...> Milk,1,2.99
      ...> Battery,6,8.00
      ...> \"""
      [
        [Item: Teddy bear, Qty: 4, Price: 34.95],
        [Item: Milk, Qty: 1, Price: 2.99],
        [Item: Battery, Qty: 6, Price: 8.00]
      ]
  """
  def sigil_v(csv, _otps) do
    non_pretty = _sigil_v(csv)
    case may_pp?(non_pretty) do
      true -> pp(non_pretty)
      _    -> non_pretty
    end
  end

  Enum.zip(Enum.map(["Item", "Qty", "Price"],&String.to_atom/1), ["Teddy bear", 4, 34.95])

  # [{:"Item", "Teddy bear"}, {:"Qty", 4}, {:"Price", 34.95}]

  defp pp([header_line | item_lines] = _lines) do
    header_line_atoms = header_line |> Enum.map(&String.to_atom/1)
    Enum.map(item_lines, fn item -> Enum.zip(header_line_atoms, item) end)
  end

  defp _sigil_v(csv) do
    csv
    |> String.rstrip
    |> String.split("\n")
    |> Enum.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    line |> String.split(",") |> Enum.map(fn item -> parse_float(item) end)
  end

  defp parse_float(value) do
    case Float.parse(value) do
      { float, _ } -> float
      :error       -> value
    end
  end

  defp may_pp?([_header_line | []] = _lines), do: false
  defp may_pp?([header_line | item_lines] = _lines) do
    count = Enum.count(header_line)
    all_string?(header_line) && all_items_have_same_elem_number?(item_lines, count)
  end

  defp all_string?(line_items) do
    Enum.all?(line_items, &is_binary/1)
  end

  defp all_items_have_same_elem_number?(items, count) do
    Enum.all?(items, fn item -> Enum.count(item) == count end)
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

  def items do
    ~v"""
    Item,Qty,Price
    Teddy bear,4,34.95
    Milk,1,2.99
    Battery,6,8.00
    """
  end
end
