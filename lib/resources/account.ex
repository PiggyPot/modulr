defmodule Modulr.Resources.Account do
  alias Modulr.Comms

  def create_by_customer(cid, params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/customers/#{cid}/accounts", params)
  end
end
