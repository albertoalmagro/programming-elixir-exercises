defmodule Stack.Supervisor do
  use Supervisor

  def start_link(initial_stack) do
    result = { :ok, pid } = Supervisor.start_link(__MODULE__, initial_stack)
    start_workers(pid, initial_stack)
    result
  end

  defp start_workers(sup, initial_stack) do
    { :ok, stash_pid } = Supervisor.start_child(sup, worker(Stack.Stash, [initial_stack]))
    { :ok, _pid }      = Supervisor.start_child(sup, supervisor(Stack.SubSupervisor,
                                                                [stash_pid]))
  end

  def init(_) do
    # When start_link is called we supervise no childen. They will be added later
    # with start_child.
    supervise [], strategy: :one_for_one
  end
end
