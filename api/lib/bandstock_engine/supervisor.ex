defmodule BandstockEngine.Supervisor do
  use Supervisor

  def start_link do
    reply = Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
    IO.inspect(reply)
    reply
  end

  def init(:ok) do
    children = [
      worker(BandstockEngine.Engine, [[name: BandstockEngine.Engine]]),
      worker(BandstockEngine.PeriodicTask, [[name: BandstockEngine.PeriodicTask]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
