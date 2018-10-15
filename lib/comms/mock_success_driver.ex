defmodule Modulr.Comms.MockSuccessDriver do
  use Agent
  alias Modulr.Comms.MockData

  def start_link do
    Agent.start_link(fn -> initial_state() end, name: __MODULE__)
  end

  def request(:get, "/customers", _) do
    customers =
      Agent.get(__MODULE__, fn state ->
        state[:customers]
        |> Map.values()
      end)

    {:ok,
     %{
       content: customers,
       page: 1,
       size: Enum.count(customers),
       totalPages: 1,
       totalSize: Enum.count(customers)
     }}
  end

  def request(:get, "/customers/" <> id, _) do
    {:ok, get_in_state(id)}
  end

  def request(:post, "/customers", params) do
    Agent.update(__MODULE__, fn state ->
      put_in(state[:customers]["C0003"], params)
    end)

    {:ok, params}
  end

  def request(:put, "/customers/" <> id, params) do
    Agent.update(__MODULE__, fn state ->
      model_instance = state[:customers][id]
      put_in(state[:customers][id], Map.merge(model_instance, params))
    end)

    {:ok, get_in_state(id)}
  end

  defp get_in_state(id) do
    Agent.get(__MODULE__, fn state -> state[:customers][id] end)
  end

  defp initial_state do
    %{
      customers: MockData.Customers.init()
    }
  end
end
