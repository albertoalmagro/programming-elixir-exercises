defmodule Stack.Server do
  use GenServer

  #####
  # External API

  def start_link(current_stack) do
    GenServer.start_link(__MODULE__, current_stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(element) do
    GenServer.cast(__MODULE__, { :push, element })
  end

  #####
  # GenServer implementation

  def handle_call(:pop, _from, [ head | tail ]) do
    { :reply, head, tail }
  end
  def handle_call(:pop, _from, []) do
    raise "Exception"
  end

  def handle_cast({ :push, element }, _) when is_integer(element) and element < 10 do
    raise "Element must be greater or equal than 10"
  end
  def handle_cast({ :push, element }, current_stack) do
    { :noreply, [ element | current_stack ] }
  end

  def terminate(reason, state) do
    IO.puts "Terminate, reason: #{inspect(reason)}, state: #{inspect(state)}"
  end
end
