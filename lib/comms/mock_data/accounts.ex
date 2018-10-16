defmodule Modulr.Comms.MockData.Accounts do
  def init do
    %{
      "A0001" => %{
        id: "A0001",
        balance: "0.00",
        createdDate: "2018-08-01T18:01:00+0000",
        currency: "GBP",
        customerId: "C0001",
        customerName: "Joe Bloggs",
        externalReference: "JOEACC",
        status: "ACTIVE"
      },
      "A0002" => %{
        id: "A0002",
        balance: "10.00",
        createdDate: "2018-08-01T18:03:00+0000",
        currency: "GBP",
        customerId: "C0002",
        customerName: "John Doe",
        externalReference: "JOHNACC",
        status: "ACTIVE"
      }
    }
  end
end
