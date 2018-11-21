defmodule Modulr.Resources.Customer do
  alias Modulr.Comms

  def list(params \\ %{}, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/customers", params)
  end

  def get(id, params \\ %{}, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/customers/#{id}", params)
  end

  @doc """
  Create a customer.

  ### Example

        Modulr.Resources.Customer.create(%{
          applicant: true, 
          type: "INDIVIDUAL", 
          expectedMonthlySpend: 20000, 
          tcsVersion: 1, 
          associates: [%{
            firstName: "Joe", 
            lastName: "Bloggs", 
            dateOfBirth: "1995-04-24", 
            type: "INDIVIDUAL",
            email: "joe@bloggs.com", 
            phone: "0123123123123", 
            homeAddress: %{
              addressLine1: "1 Here Street, 
              country: "GB", 
              postCode: "L1 1AB", 
              postTown: "London"
            }
          }]
        })
  """
  def create(params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/customers", params)
  end

  def update(id, params, driver \\ Comms.HttpDriver) do
    driver.request(:put, "/customers/#{id}", params)
  end
end
