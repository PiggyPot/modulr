defmodule Modulr.Resources.Customer do
  alias Modulr.Comms

  def list(params \\ %{}, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/customers", params)
  end

  def get(id, params \\ %{}, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/customers/#{id}", params)
  end

  def create(params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/customers", params)
  end

  def update(id, params, driver \\ Comms.HttpDriver) do
    driver.request(:put, "/customers/#{id}", params)
  end
end
