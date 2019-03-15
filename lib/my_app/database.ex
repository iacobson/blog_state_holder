defmodule MyApp.Database do
  @moduledoc """
  For the purpose of this exercise we do not need a real database.
  We will store 2 example entitys in simple files
  """
  alias MyApp.Entity

  @db_path "./lib/db/"

  @spec get_entity(entity_id :: Entity.id()) :: {:ok, Entity.t()}
  def get_entity(entity_id) do
    entity =
      File.read!(@db_path <> entity_id)
      |> String.split("\n", trim: true)
      |> Enum.reduce(%Entity{}, &entity_from_string/2)

    {:ok, entity}
  end

  @spec set_entity_state(entity_id :: Entity.id(), state :: Entity.state()) :: :ok
  def set_entity_state(entity_id, state) do
    entity = entity_to_string(entity_id, state)
    File.write!(@db_path <> entity_id, entity)
  end

  defp entity_from_string("id:" <> id, %Entity{} = entity) do
    %Entity{entity | id: id}
  end

  defp entity_from_string("state:" <> state, %Entity{} = entity) do
    %Entity{entity | state: String.to_atom(state)}
  end

  defp entity_to_string(id, state) do
    """
    id:#{id}
    state:#{to_string(state)}
    """
  end
end
