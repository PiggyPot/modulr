defmodule Modulr.Resources.InboundPayment do
  alias Modulr.Comms

  @doc """
  Deposit some mock money into an existing account.

  ## Examples

        Modulr.Resources.InboundPayment.create(%{
          type: "PI_FAST", 
          description: "some desc", 
          accountId: "A123B123", 
          amount: 20, 
          payerDetail: %{
            name: "Joe Bloggs", 
            address: %{
              addressLine1: "1 Here Street", 
              country: "GB", 
              postCode: "L1 1LB", 
              postTown: "London"
            }, 
            identifier: %{
              accountNumber: "12345678", 
              sortCode: "000000", 
              type: "SCAN"
            }
          }
        })
  """
  def create(params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/credit", params)
  end
end
