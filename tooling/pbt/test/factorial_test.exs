defmodule FactorialTest do
  use ExUnit.Case

  describe "Factorial of" do
    test "1 is 1" do
      assert Factorial.of(1) == 1
    end

    test "5 is 120" do
      assert Factorial.of(5) == 120
    end

    test "10 is 3628800" do
      assert Factorial.of(10) == 3628800
    end
  end
end
