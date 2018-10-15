defmodule Modulr.Comms.MockData.Customers do
  def init do
    %{
      "C0001" => %{
        id: "C0001",
        name: "Joe Bloggs",
        createdDate: "2018-08-01T18:00:00+0000",
        expectedMonthlySpend: 10000,
        tcsVersion: 1,
        type: "INDIVIDUAL"
      },
      "C0002" => %{
        id: "C0002",
        name: "John Doe",
        createdDate: "2018-08-02T18:00:00+0000",
        expectedMonthlySpend: 20000,
        tcsVersion: 1,
        type: "INDIVIDUAL"
      }
    }
  end
end
