defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "first element to pop is 5" do
    assert Stack.Server.pop == 5
  end

  test "pushes new elements first in the stack" do
    :ok = Stack.Server.push "dog"
    assert Stack.Server.pop == "dog"
  end
end
