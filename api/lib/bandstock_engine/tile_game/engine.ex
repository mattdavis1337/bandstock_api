defmodule BandstockEngine.TileGame.Engine do
  use GenServer
  use Tensor

  alias BandstockEngine.TileGame
  alias BandstockApi.Data.Structs.PriorityQueue

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(state) do
    mat = Matrix.new([[%{color: "red"},%{color: "blue"},3],[4,5,6],[7,8,9]],3,3)
    {:ok, %{mat: mat, pq: PriorityQueue.new, time: 0}}
  end

  def say(engine, msg) do
    GenServer.cast(engine, {:say, msg})
  end

  def scheduleAction(engine, action, delay) do
    GenServer.cast(engine, {:add, action, delay})
  end

  def doAction(engine, action) do
    GenServer.cast(engine, {:do, action})
  end



  # GenServer callbacks

  def handle_call({:say, msg}, _from, state) do
    IO.inspect(msg);
    {:reply, msg, state}
  end

  #send out the next batch of messages
  def handle_cast({:pulse, {time, timeBatch}}, state) do
    #pull items off the top of the priorityQueue until the next one is bigger than the Timebatch you're grabbing right now
    IO.puts(time);
    IO.puts(timeBatch);
  end

  def handle_cast({:say, msg}, state) do
    #state = Map.replace!(state, :mat, Matrix.rotate_clockwise(state.mat));
    #IO.inspect(state.mat);
    BandstockApiWeb.Endpoint.broadcast!("board:1", "board_output", %{response: "Message from BandstockEngine.TileGame.Engine! (1)"} )

    {:noreply, state}
  end

  def handle_cast({:do, action}, state) do
    #state = Map.replace!(state, :mat, Matrix.rotate_clockwise(state.mat));
    #IO.inspect(state.mat);
    BandstockApiWeb.Endpoint.broadcast!("board:1", "board_output", %{response: "Message from BandstockEngine.TileGame.Engine! (2)"} )
    {:noreply, state}
  end

  def handle_cast({:add, action, delay}, state) do
    Map.replace!(state, :pq, PriorityQueue.insert_with_priority(state.pq, {action, state.time+delay}))
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
end
