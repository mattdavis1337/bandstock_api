defmodule BandstockEngine.PeriodicTask do
  use GenServer

  @timeout 1_000  #repeat every 1 second

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, engine} = BandstockEngine.Engine.start_link([])
    {:ok, %{engine: engine, clock: {System.monotonic_time(), 0} }, @timeout}
  end

  def handle_info(:timeout, state) do
    {prevTime, elapsed} = state.clock;
    time = System.monotonic_time();
    state = Map.replace!(state, :clock, {time, time-prevTime});
    IO.inspect(state.clock)
    #BandstockEngine.Engine.say(state.engine, "yes")
    {:noreply, state, @timeout}
  end
end
