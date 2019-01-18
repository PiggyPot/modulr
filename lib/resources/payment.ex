defmodule Modulr.Resources.Payment do
  alias Modulr.Comms

  @doc """
  Create a Payment to external bank accounts via
  Faster Payments and transfers to other Modulr
  accounts. Requests to Payments are asynchronous.

  ## Example

  *Transfer to another Modulr account*

  Modulr.Resources.Payment.create(%{
    amount: 10.50,
    currency: "GBP",
    destination: %{
      type: "ACCOUNT",
      id: "A120BCEZ"
    },
    reference: "REF123",
    sourceAccountId: "A120BCF1"
  })
  """
  def create(params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/payments", params)
  end

  @doc """
  Get a payment

  ## Example

      Modulr.Resources.Payment.get(id: "P12300ABCD")
  """
  def get(params, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/payments", params)
  end

  @doc """
  Make a Batch Payment (multiple payments in single request)

  ## Examples

      Modulr.Resources.Payment.create_batch(%{
        externalReference: "BatchRef",
        strictProcessing: true,
        payments: [%{
          amount: 20.50,
          currency: "GBP",
          destination: %{
            type: "ACCOUNT",
            id: "A123DEFG"
          },
          externalReference: "PaymentRef",
          reference: "BankStatmentRef",
          sourceAccountId: "A120BCF1"
        }, %{
          amount: 10.90,
          currency: "GBP",
          destination: %{
            type: "ACCOUNT",
            id: "A456ABCD"
          },
          externalReference: "PaymentRef",
          reference: "BankStatmentRef",
          sourceAccountId: "A120BCF1"
        }]
      }})
  """
  def create_batch(params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/batchpayments", params)
  end

  @doc """
  Gets details about a given batch payment

  ## Example

        Modulr.Resources.Payment.get_batch("D123000123")
  """
  def get_batch(bid, params \\ %{}, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/batchpayments/#{bid}", params)
  end
end
