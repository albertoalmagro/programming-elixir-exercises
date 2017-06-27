defmodule StatsPropertyTest do
  use ExUnit.Case
  use ExCheck

  describe "Stats on lists of ints" do
    property "could not negative" do
      for_all l in list(int()), do: Stats.count(l) >= 0
    end

    property "single element lists are their own sum" do
      for_all number in real() do
        Stats.sum([number]) == number
      end
    end

    # Implies discards the value once generated if it doesn't meet the condition.
    property "sum equals average times count with implies" do
      for_all l in list(int()) do
        implies length(l) > 0 do
          abs(Stats.sum(l) - Stats.average(l) * Stats.count(l)) < 1.0e-6
        end
      end
    end

    # such_that prevents the generator to generate values that don't meet the condition.
    property "sum equals average times count with such_that" do
      for_all l in such_that(l in list(int()) when length(l) > 0) do
        abs(Stats.sum(l) - Stats.average(l) * Stats.count(l)) < 1.0e-6
      end
    end
  end
end
