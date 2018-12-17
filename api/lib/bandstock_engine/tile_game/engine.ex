defmodule BandstockEngine.TileGame.Engine do
  use GenServer

  alias BandstockEngine.TileGame

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def say(engine, msg) do
    GenServer.cast(engine, {:say, msg})
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
    IO.inspect(msg);
    {:reply, msg, state}
  end

  def handle_cast({:say, msg}, state) do
    IO.inspect(msg);
    {:noreply, state}
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
