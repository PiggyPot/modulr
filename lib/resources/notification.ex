defmodule Modulr.Resources.Notification do
  alias Modulr.Comms

  @doc """
  Retrieve a specific notification by unique reference for a given customer.

  ## Example

        Modulr.Resources.Notification.get_for_customer("C123456", "W123ABCD")
  """
  def get_for_customer(cid, nid, params \\ %{}, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/customers/#{cid}/notifications/#{nid}", params)
  end

  @doc """
  List all notifications for a given customer.

  ## Example

        Modulr.Resources.Notification.list_for_customer("C123456")
  """
  def list_for_customer(cid, params \\ %{}, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/customers/#{cid}/notifications", params)
  end

  @doc """
  Set up a Notification for a given customer.

  ## Example

        Modulr.Resources.Notification.create_for_customer("C123456", %{
          channel: "WEBHOOK",
          config: %{
            retry: true,
            secret: "01234567890123456789012345678912"},
            destinations: ["https://yourserver/endpoint"], 
            type: "PAYIN"
          }
        )
  """
  def create_for_customer(cid, params, driver \\ Comms.HttpDriver) do
    driver.request(:post, "/customers/#{cid}/notifications", params)
  end

  def update_for_customer(cid, nid, params, driver \\ Comms.HttpDriver) do
    driver.request(:put, "/customers/#{cid}/notifications/#{nid}", params)
  end

  @doc """
  Check if a webhook has failed since a given date/time (`from`)

  ## Example

        Modulr.Resources.Notification.check_if_failed("W123ABCD", %{
          from: "2017-01-28T01:01:01+0000"
        })
  """
  def check_if_failed(id, params, driver \\ Comms.HttpDriver) do
    driver.request(:get, "/webhooks/#{id}/failures", params)
  end
end
