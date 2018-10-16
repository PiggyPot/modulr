defmodule Modulr.Resources.Account do
  alias Modulr.Comms

  def get(id, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/accounts/#{id}", %{})
  end

  def create_by_customer(cid, params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/customers/#{cid}/accounts", params)
  end
end
