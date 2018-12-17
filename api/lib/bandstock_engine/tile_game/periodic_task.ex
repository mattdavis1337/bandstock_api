defmodule BandstockEngine.TileGame.PeriodicTask do
  use GenServer

  alias BandstockEngine.TileGame

  @timeout 999  #repeat every 1 second

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, engine} = TileGame.Engine.start_link([])
    {:ok, %{engine: engine, clock: {System.monotonic_time(), 0} }, @timeout}
  end

  def handle_info(:timeout, state) do
    {prevTime, elapsed} = state.clock;
    time = System.monotonic_time(:millisecond);
    TileGame.Engine.say(state.engine, {time, time-prevTime});

    #GenServer.cast(state.engine, {:say, {time, time-prevTime}})
    state = Map.replace!(state, :clock, {time, time-prevTime});
    #BandstockEngine.Engine.say(state.engine, "yes")
    {:noreply, state, @timeout}
  end
end
