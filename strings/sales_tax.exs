defmodule SalesTax do

  def parse_orders(file) do
    File.stream!(file)
    |> Stream.map(&parse_order(&1))
    |> Stream.filter(fn list -> length(list) > 0 end)
    |> Enum.to_list
  end

  @tax_rates [ NC: 0.075, TX: 0.08 ]
  def calculate_with_total_amount(orders) do
    for order <- orders, [id, ship_to, net_amount] = Keyword.values(order) do
      if ship_to in Keyword.keys(@tax_rates) do
        [id: id, ship_to: ship_to, net_amount: net_amount, total_amount: add_taxes(net_amount, ship_to)]
      else
        [id: id, ship_to: ship_to, net_amount: net_amount, total_amount: net_amount]
      end
    end
  end

  defp add_taxes(net_amount, ship_to), do: net_amount * (1 + @tax_rates[ship_to])

  defp parse_order(line), do: line |> String.split(",") |> parse_line

  defp parse_line([id, << ":" :: utf8, ship_to :: binary >> , net_amount]) do
    [
      id: String.to_integer(id),
      ship_to: String.to_atom(ship_to),
      net_amount: String.to_float(String.trim(net_amount))
    ]
  end
  defp parse_line(_), do: []
end

import SalesTax

parse_orders("sales.txt")
|> calculate_with_total_amount
|> IO.inspect
