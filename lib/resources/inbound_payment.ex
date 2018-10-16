defmodule Modulr.Resources.InboundPayment do
  alias Modulr.Comms

  def create(params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/credit", params)
  end
end
