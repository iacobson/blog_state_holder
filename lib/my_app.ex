defmodule MyApp do
  @moduledoc """
  The functions that the MyApp app exposes to be used by the rest of the project.
  """
  alias MyApp.{WorkerSupervisor, Worker, Entity}

  @spec get_entity(id :: Entity.id()) :: {:ok, Entity.t()}
  def get_entity(id) do
    with {:ok, _pid} <- WorkerSupervisor.get_or_start_worker(id) do
      Worker.get_entity(id)
    end
  end

  @spec set_entity_state(id :: Entity.id(), state :: Entity.state()) :: :ok
  def set_entity_state(id, state) do
    with {:ok, _pid} <- WorkerSupervisor.get_or_start_worker(id) do
      Worker.set_entity_state(id, state)
    end
  end
end
