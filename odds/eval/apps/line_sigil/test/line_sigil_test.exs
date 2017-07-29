defmodule LineSigilTest do
  use ExUnit.Case
  import LineSigil

  test "the truth" do
    value = ~l"""
    line1
    line2
    line3
    """
    assert value == ["line1", "line2", "line3"]
  end
end
