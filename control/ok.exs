defmodule MyKernel do
  def ok!({ :ok, data }),      do: data
  def ok!({ :error, reason }), do: raise "Can not process data: #{reason}"
  def ok!(_),                  do: raise "Unexpected input"
end
