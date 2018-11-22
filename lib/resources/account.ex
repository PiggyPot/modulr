defmodule Modulr.Resources.Account do
  alias Modulr.Comms

  def get(id, params \\ %{}, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/accounts/#{id}", params)
  end

  @doc """
  Create an account for an existing customer.

  ## Example

        Modulr.Resources.Account.create_by_customer("C123456", %{currency: "GBP"})
  """
  def create_by_customer(cid, params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/customers/#{cid}/accounts", params)
  end
end
