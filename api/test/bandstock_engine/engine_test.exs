defmodule BandstockEngineTest.EngineTest do
  use ExUnit.Case
  use ExUnit.Callbacks

  setup do
   engine = start_supervised!(BandstockEngine.Engine);
   %{engine: engine}
  end

  test "caches and finds the correct data", %{engine: engine} do
    IO.puts("EngineTest")
    assert BandstockEngine.Engine.say(engine, "Hello there") == %{says: ["Hello there"]}
    assert BandstockEngine.Engine.say(engine, "Hello there2") == %{says: ["Hello there2", "Hello there"]}

    #assert BandstockEngine.Engine.history(engine) == {:history, ["Hello there"]};

  #  assert BandstockEngine.Engine.fetch("A", fn -> "" end) == %{id: 1, long_url: "http://www.example.com"}
  end
end
