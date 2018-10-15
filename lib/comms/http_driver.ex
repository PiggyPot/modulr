defmodule Modulr.Comms.HttpDriver do
  @api_base Application.fetch_env!(:modulr, :api_base)
  @api_version Application.fetch_env!(:modulr, :api_version)
  @api_key Application.fetch_env!(:modulr, :api_key)
  @api_hmac Application.fetch_env!(:modulr, :api_hmac)

  def request(:get, path) do
    path
    |> api_url
    |> HTTPotion.get(headers())
    |> decode_json()
  end

  def request(:get, path, params) do
    url_params = params |> URI.encode_query()

    "#{path}?#{url_params}"
    |> api_url
    |> HTTPotion.get(headers())
    |> decode_json()
  end

  def request(:post, path, body) do
    hdrs =
      [body: Poison.encode!(body)]
      |> headers

    path
    |> api_url
    |> HTTPotion.post(hdrs)
    |> decode_json()
  end

  def request(:put, path, body) do
    hdrs =
      [body: Poison.encode!(body)]
      |> headers

    path
    |> api_url
    |> HTTPotion.put(hdrs)
    |> decode_json()
  end

  defp decode_json(resp_map) do
    case resp_map.body do
      "" -> {:ok, "No Body"}
      body -> Poison.decode(body)
    end
    |> create_response(resp_map)
  end

  defp create_response({:ok, body}, resp_map) do
    case resp_map.status_code do
      x when x in [200, 201, 204] -> {:ok, body}
      _ -> {:error, body}
    end
  end

  defp create_response({:error, _}, _), do: {:error, "There was an issue decoding the body"}

  defp api_url(url) do
    @api_base <> url
  end

  defp headers, do: headers([])

  defp headers(body) do
    # [
    #   headers: [
    #     Authorization: "Bearer #{@access_token}",
    #     "GoCardless-Version": @api_version,
    #     Accepts: "application/json",
    #     "Content-Type": "application/json"
    #   ]
    # ] ++ body
  end
end
