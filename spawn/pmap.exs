defmodule Parallel do
  def pmap(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn(elem) ->
          spawn_link fn -> (send me, { self(), fun.(elem) }) end
        end)
    |> Enum.map(fn(pid) ->
          receive do
            { ^pid, result } -> result
          end
        end)
  end
end

defmodule ParallelTask do
  def pmap(collection, fun) do
    collection
    |> Enum.map(&(Task.async(fn -> fun.(&1) end)))
    |> Enum.map(&Task.await/1)
  end
end

defmodule CLI do
  def run(module, num_elem), do: IO.puts inspect _run(module, 1..num_elem)

  defp _run(Enum,     collection), do: :timer.tc(Enum,     :map, [collection, &(&1 * &1)])
  defp _run(Parallel, collection), do: :timer.tc(Parallel, :pmap, [collection, &(&1 * &1)])
  defp _run(ParallelTask, collection) do
    :timer.tc(ParallelTask, :pmap, [collection, &(&1 * &1)])
  end
end
