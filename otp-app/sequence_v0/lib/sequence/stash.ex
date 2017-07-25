defmodule Sequence.Stash do
  use GenServer
  require Logger

  @vsn "1"
  defmodule State do
    defstruct current_value: 0, current_delta: 1
  end

  #####
  # External API

  def start_link({ current_value, current_delta }) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, { current_value, current_delta })
  end

  def save_value(pid, { value, delta }) do
    GenServer.cast pid, {:save_value, { value, delta} }
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  #####
  # GenServer implementation

  def init({ current_value, current_delta }) do
    {:ok, %State{current_value: current_value, current_delta: current_delta} }
  end

  def handle_call(:get_value, _from, state) do
    { :reply, state, state }
  end

  def handle_cast({ :save_value, { current_value, current_delta }}, _current_state) do
    {
      :noreply,
      %State{current_value: current_value, current_delta: current_delta}
    }
  end

  #####
  # Callback to upgrade state

  def code_change("0", old_state = current_value, _extra) do
    new_state = %State{current_value: current_value,
                       current_delta: 1
                      }
    Logger.info "Changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    {:ok, new_state}
  end
end
