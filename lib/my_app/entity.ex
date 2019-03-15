defmodule MyApp.Entity do
  @moduledoc """
  The model of an entity. For our example we care just about the id and state
  The id format is `entity_1`
  """

  alias __MODULE__

  @type id :: String.t()
  @type state() :: :initialized | :working | :finalized

  @type t() :: %Entity{
          id: id(),
          state: state()
        }

  defstruct [:id, :state]
end
