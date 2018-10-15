defmodule Modulr.Comms.MockFailureDriver do
  def request(:get, "/customers", _) do
    {:error, ""}
  end

  def request(:post, "/customers", params) do
    {:error, ""}
  end
end
