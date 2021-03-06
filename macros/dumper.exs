defmodule My do
  defmacro macro(param) do
    IO.inspect param
  end
end

defmodule Test do
  require My

  # These values represent themselves
  My.macro :atom        #=> :atom
  My.macro 1            #=> 1
  My.macro 1.0          #=> 1.0
  My.macro [1,2,3]      #=> [1,2,3]
  My.macro "binaries"   #=> "binaries"
  My.macro { 1, 2 }     #=> {1,2}
  My.macro do: 1        #=> [do: 1]

  # And these are represented by 3-element tuples

  My.macro { 1,2,3,4,5 }
  #=>  {:"{}",[line:21],[1,2,3,4,5]}

  My.macro do: ( a = 1; a+a )
  #=>  [do:
  #     {:__block__,[].
  #       [{:=,[line: 24],[{:a,[line: 24],nil},1]},
  #        {:+,[line: 24],[{:a,[line: 24],nil},{:a,[line: 24],nil}]}]}]

  My.macro do
    1+2
  else
    3+4
  end
  #=>  [do: {:+,[line: 31],[1,2]},
  #     else: {:+,[line: 33],[3,4]}]
end
