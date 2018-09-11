defmodule BandstockEngineTest.PeriodTaskTest do
  use ExUnit.Case
  use ExUnit.Callbacks

  setup do
   %{ptask: start_supervised!(BandstockEngine.PeriodicTask)}
  end

  test "executes a periodic task", %{ptask: ptask} do
    #assert BandstockEngine.Engine.say(engine, "Hello there") == ["Hello there"]
    #assert BandstockEngine.Engine.say(engine, "Hello there2") == ["Hello there2", "Hello there"]
  end
end
