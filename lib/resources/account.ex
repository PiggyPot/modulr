defmodule Modulr.Resources.Account do
  alias Modulr.Comms

  def get(id, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/accounts/#{id}", %{})
  end

  @doc """
  Create an account for an existing customer.

  ## Example

        Modulr.Resources.Account.create_by_customer("C120AJWE", %{currency: "GBP"})
  """
  def create_by_customer(cid, params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/customers/#{cid}/accounts", params)
  end
end
