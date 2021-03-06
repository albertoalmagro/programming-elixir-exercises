defmodule WorkingWithMultipleProcesses5a do
  import :timer, only: [ sleep: 1 ]

  def send_and_exit(pid) do
    send pid, "Hello from child!"
    exit(:normal)
  end

  def receive_messages do
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED #{inspect msg}"
        receive_messages()
    after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end

  def run do
    spawn_monitor(WorkingWithMultipleProcesses5a, :send_and_exit, [self()])
    sleep 500
    receive_messages()
  end
end

WorkingWithMultipleProcesses5a.run
