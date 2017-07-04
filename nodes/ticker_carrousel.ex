defmodule TickerCarrousel do
  @interval 2000 # 2 seconds
  @name     :ticker_carrousel

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "Registering #{inspect pid}"
        put_client_at_the_end(clients, pid)
        |> generator
      after
        @interval ->
          IO.puts "tick"
          _generator(clients)
    end
  end

  defp _generator([]), do: generator([])
  defp _generator([ client | tail ]) do
    send client, { :tick }
    put_client_at_the_end(tail, client)
    |> generator
  end

  defp put_client_at_the_end(clients, client) do
    [ client | Enum.reverse(clients)] |> Enum.reverse
  end
end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    TickerCarrousel.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver()
    end
  end
end
