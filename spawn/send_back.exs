defmodule SendBack do
  def send_and_return(to) do
    receive do
      token ->
        send to, token
    end
  end
end

first  = spawn(SendBack, :send_and_return, [self()])
second = spawn(SendBack, :send_and_return, [self()])

send first,  "fred"
send second, "betty"

receive do
  token ->
    IO.puts "Received back: #{token}"
end
receive do
  token ->
    IO.puts "Received back: #{token}"
end
