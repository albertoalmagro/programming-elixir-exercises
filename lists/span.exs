defmodule MyList do
  def span(a, a), do: [ a ]
  def span(from, to) when from < to do
    [ from | span(from + 1, to) ]
  end
  def span(from, to) when from > to do
    raise "from can't be higher than to!"
  end
end
