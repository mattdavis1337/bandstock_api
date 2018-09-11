defmodule BandstockEngineTest.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(BandstockEngine.Registry)
    %{registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    assert BandstockEngine.Registry.lookup(registry, "shopping") == :error

    BandstockEngine.Registry.create(registry, "shopping")
    assert {:ok, bucket} = BandstockEngine.Registry.lookup(registry, "shopping")

    BandstockEngine.Bucket.put(bucket, "milk", 1)
    assert BandstockEngine.Bucket.get(bucket, "milk") == 1

  
  end
end
