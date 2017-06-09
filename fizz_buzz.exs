fizzbuzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, a -> a
end

IO.puts fizzbuzz.(0,0,1)
IO.puts fizzbuzz.(0,2,1)
IO.puts fizzbuzz.(2,0,1)
IO.puts fizzbuzz.(1,1,"hello")

remainder_buzz = fn n -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end

IO.puts remainder_buzz.(10)
IO.puts remainder_buzz.(11)
IO.puts remainder_buzz.(12)
IO.puts remainder_buzz.(13)
IO.puts remainder_buzz.(14)
IO.puts remainder_buzz.(15)
IO.puts remainder_buzz.(16)
