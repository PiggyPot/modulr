defmodule Modulr.Comms.MockSuccessDriver do
  use Agent
  alias Modulr.Comms.MockData

  def start_link do
    Agent.start_link(fn -> initial_state() end, name: __MODULE__)
  end

  ##############################################
  # Dispatchers
  ##############################################
  def request(:get, path, params) do
    generate_response(:get, parse_path(path), params)
  end

  def request(:post, path, params) do
    generate_response(:post, parse_path(path), params)
  end

  def request(:put, path, params) do
    generate_response(:put, parse_path(path), params)
  end

  ##############################################
  # Customer Endpoints
  ##############################################

  def generate_response(:get, ["customers"], _) do
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

  def generate_response(:get, ["customers", id], _) do
    {:ok, get_in_state(:customers, id)}
  end

  def generate_response(:post, ["customers"], params) do
    Agent.update(__MODULE__, fn state ->
      put_in(state[:customers]["C0003"], params)
    end)

    {:ok, params}
  end

  def generate_response(:put, ["customers", id], params) do
    Agent.update(__MODULE__, fn state ->
      model_instance = state[:customers][id]
      put_in(state[:customers][id], Map.merge(model_instance, params))
    end)

    {:ok, get_in_state(:customers, id)}
  end

  ##############################################
  # Account Endpoints
  ##############################################

  def generate_response(:get, ["accounts", id], _) do
    {:ok, get_in_state(:accounts, id)}
  end

  def generate_response(:post, ["customers", cid, "accounts"], params) do
    Agent.update(__MODULE__, fn state ->
      new_id = "C" <> Integer.to_string(:rand.uniform(10000))
      put_in(state[:customers][new_id], params)
    end)

    {:ok, params}
  end

  ##############################################
  # Inbound Payment Endpoints
  ##############################################

  def generate_response(:post, ["credit"], params) do
    Agent.update(__MODULE__, fn state ->
      model_instance = state[:accounts][params.accountId]
      current_balance = model_instance.balance |> String.to_float()
      new_balance = (current_balance + params.amount) |> Float.to_string()

      put_in(
        state[:accounts][params.accountId],
        Map.merge(model_instance, %{balance: new_balance})
      )
    end)

    {:ok, "Credited account"}
  end

  ##############################################
  # Helpers
  ##############################################

  defp get_all_by_in_state(model, params) do
    Agent.get(__MODULE__, fn state ->
      state[model]
      |> Map.values()
      |> Enum.filter(fn model ->
        is_subset_of_map(params, model)
      end)
    end)
  end

  defp get_by_in_state(model, params) do
    case get_all_by_in_state(model, params) do
      [head] -> head
      _ -> nil
    end
  end

  defp is_subset_of_map(potential_subset, base_map) do
    Enum.all?(potential_subset, &(&1 in base_map))
  end

  defp get_in_state(model, id) do
    Agent.get(__MODULE__, fn state -> state[model][id] end)
  end

  defp initial_state do
    %{
      customers: MockData.Customers.init(),
      accounts: MockData.Accounts.init()
    }
  end

  defp parse_path(path) do
    path
    |> String.trim("/")
    |> String.split("/")
  end
end
