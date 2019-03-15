defmodule MyApp.WorkerSupervisor do
  @moduledoc "Starts and supervises worker entity servers"

  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def get_or_start_worker(entity_id) do
    case DynamicSupervisor.start_child(__MODULE__, {MyApp.Worker, entity_id}) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
