defmodule Modulr.Resources.Beneficiary do
  alias Modulr.Comms

  def get(params \\ %{}, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/beneficiaries", params)
  end

  @doc """
  Create an beneficiary for an existing customer.

  ## Example

        Modulr.Resources.Beneficiary.create_by_customer("C123456", %{
          defaultReference: "Default Ref", 
          destinationIdentifier: %{
            accountNumber: "12345678", 
            sortCode: "000000", 
            type: "SCAN"
          }, 
          name: "John Jones"
        })
  """
  def create_by_customer(cid, params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/customers/#{cid}/beneficiaries", params)
  end
end
