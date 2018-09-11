defmodule BandstockEngineTest.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = BandstockEngine.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert BandstockEngine.Bucket.get(bucket, "milk") == nil

    BandstockEngine.Bucket.put(bucket, "milk", 3)
    assert BandstockEngine.Bucket.get(bucket, "milk") == 3
  end
end
