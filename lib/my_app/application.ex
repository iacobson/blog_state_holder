defmodule MyApp.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    connect_nodes()

    children = [
      MyApp.WorkerSupervisor
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp connect_nodes() do
    Application.get_env(:my_app, :nodes)
    |> Enum.each(&Node.connect(&1))
  end
end
