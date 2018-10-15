defmodule Modulr.Comms.MockSuccessDriver do
  def request(:get, "/customers", _) do
    {:ok,
     %{
       content: [
         %{
           name: "Phil"
         }
       ],
       page: 1,
       size: 3,
       totalPages: 1,
       totalSize: 3
     }}
  end

  def request(:post, "/customers", params) do
    {:ok, ""}
  end

  def request(:put, "/customers", body) do
    {:ok, ""}
  end
end
