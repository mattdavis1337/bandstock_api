defmodule BandstockEngine.Engine do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def say(engine, msg) do
    GenServer.call(engine, {:say, msg})
  end

  #defp get(msg) do
  #  IO.puts("in get")
  #  case GenServer.call(__MODULE__, {:get, msg}) do
  #    {:reply, reply} -> {:reply, reply}
  #  end
  #end

  #defp set(slug, value) do
  #  IO.puts("in set")
  #  GenServer.call(__MODULE__, {:set, msg, value})
  #end

  # GenServer callbacks

  def handle_call({:say, msg}, _from, state) do
    time = System.monotonic_time();
    IO.puts("in handle_call :say ")
    state = Map.replace!(state, :says, [msg | state.says])
    {:reply, state, state}
  end

  #def handle_call(:set, msg, value) do
  #  IO.puts("in handle_call :set")
  #  {:reply, "Received in :set - #{msg}", value}
  #end

  #def handle_call(msg, state) do
  #  IO.puts("in handle_call")
  #  {:noreply, state}
  #end

  def handle_info(msg, state) do
    {:noreply, state}
  end

  def init(args) do
    {:ok, %{says: []}}
  end
end
