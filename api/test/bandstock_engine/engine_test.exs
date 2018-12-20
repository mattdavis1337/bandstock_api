defmodule BandstockEngineTest.EngineTest do
  use ExUnit.Case
  use ExUnit.Callbacks
  alias BandstockEngine.TileGame.Engine
  alias BandstockApi.Game.Structs.Action

  setup do
    #{:ok, server_pid} = BandstockEngine.TileGame.Engine;
    engine = start_supervised!(Engine);
    %{engine: engine}
  end

  test "starts correctly", %{engine: engine} do
    action = %Action{action: "swap"}
    Engine.scheduleAction(engine, action, 500)
    Engine.scheduleAction(engine, action, 600)
    Engine.scheduleAction(engine, action, 900)


    

    #IO.puts("EngineTest")
    #IO.inspect(pt.getState)


    #assert BandstockEngine.Engine.say(engine, "Hello there") == %{says: ["Hello there"]}
    #assert BandstockEngine.Engine.say(engine, "Hello there2") == %{says: ["Hello there2", "Hello there"]}

    #assert BandstockEngine.Engine.history(engine) == {:history, ["Hello there"]};

  #  assert BandstockEngine.Engine.fetch("A", fn -> "" end) == %{id: 1, long_url: "http://www.example.com"}
  end
end
