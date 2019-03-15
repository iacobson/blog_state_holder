defmodule MyApp.Worker do
  @moduledoc """
  Entity processing server.
  Holds an entity as state (one process per processed entity).
  """

  use GenServer

  alias MyApp.{Database, Entity}

  ## API

  @spec start_link(id :: Entity.id()) :: {:ok, pid()}
  def start_link(id) do
    GenServer.start_link(__MODULE__, id, name: {:global, String.to_atom(id)})
  end

  @spec get_entity(id :: Entity.id()) :: {:ok, Entity.t()}
  def get_entity(id) do
    GenServer.call({:global, String.to_atom(id)}, :get_entity)
  end

  @spec set_entity_state(id :: Entity.id(), state :: Entity.state()) :: :ok
  def set_entity_state(id, state) do
    GenServer.call({:global, String.to_atom(id)}, {:set_entity_state, state})
  end

  ## CALLBACK

  def init(id) do
    Database.get_entity(id)
  end

  def handle_call(:get_entity, _from, entity) do
    {:reply, {:ok, entity}, entity}
  end

  def handle_call({:set_entity_state, state}, _from, entity) do
    with :ok <- Database.set_entity_state(entity.id, state),
         {:ok, updated_entity} <- Database.get_entity(entity.id) do
      {:reply, :ok, updated_entity}
    end
  end
end
