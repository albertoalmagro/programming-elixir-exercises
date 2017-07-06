defmodule TickerRing do
  @interval 2000 # 2 seconds
  @name     :ticker_ring

  def start do
    pid = spawn(__MODULE__, :receiver, [[]])
    :global.register_name(@name, pid)
    send pid, { :tick, [ pid ] }
  end

  def register do
    pid = spawn(__MODULE__, :receiver, [[]])
    send :global.whereis_name(@name), { :register, pid }
  end

  def receiver(clients) do
    receive do
      { :register, pid } ->
        IO.puts "Registering #{inspect pid}"
        receiver([ pid | clients ])

      { :tick, old_clients } ->
        IO.puts "tock in client"
        :timer.sleep(@interval)
        IO.puts "tick"
        clients = merge_clients(clients, old_clients)
        send_next(clients)
        receiver(clients)
    end
  end

  defp merge_clients(clients, old_clients) do
    Enum.uniq(clients ++ old_clients)
  end

  defp send_next(clients) do
    { next, clients } = next_and_send_back(clients)
    send next, { :tick, clients }
  end

  defp next_and_send_back([]), do: { nil, [] }
  defp next_and_send_back([ next | []]), do: { next, [ next ] }
  defp next_and_send_back([ next | tail ]) do
    { next, Enum.reverse [ next | Enum.reverse(tail)] }
  end
end
