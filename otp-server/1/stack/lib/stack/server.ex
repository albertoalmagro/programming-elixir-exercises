defmodule Stack.Server do
  use GenServer

  def handle_call(:pop, _from, [ head | tail ]) do
    { :reply, head, tail }
  end
  def handle_call(:pop, _from, []) do
    { :reply, nil, [] }
  end

  def handle_cast({ :push, element }, current_stack) do
    { :noreply, [ element | current_stack ] }
  end
end
