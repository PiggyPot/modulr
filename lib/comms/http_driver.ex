defmodule Modulr.Comms.HttpDriver do
  require Logger

  def request(:get, path, params) do
    url_params = params |> URI.encode_query()

    "#{path}?#{url_params}"
    |> api_url()
    |> HTTPoison.get(headers(), options())
    |> decode_json()
  end

  def request(:post, path, params) do
    path
    |> api_url()
    |> HTTPoison.post(Poison.encode!(params), headers(), options())
    |> decode_json()
  end

  def request(:put, path, params) do
    path
    |> api_url()
    |> HTTPoison.put(Poison.encode!(params), headers(), options())
    |> decode_json()
  end

  defp api_url(url) do
    api_base() <> url
  end

  defp headers do
    date_header = rfc_7231_date()
    nonce_header = create_nonce_header()

    auth_header =
      create_signature(date_header, nonce_header)
      |> auth_header()

    [
      Date: date_header,
      "Content-Type": "application/json;charset=UTF-8",
      "x-mod-nonce": nonce_header,
      "x-mod-version": api_version(),
      Authorization: auth_header
    ]
  end

  defp options do
    [ssl: [{:versions, [:"tlsv1.2"]}]]
  end

  defp decode_json({:ok, resp_map}) do
    case resp_map.body do
      "" -> {:ok, "No Body"}
      body -> Poison.decode(body)
    end
    |> create_response(resp_map)
  end

  defp decode_json({:error, error}) do
    Logger.info("decode_json: #{inspect(error)}")

    case error do
      "" -> {:error, "Something went wrong"}
      e -> Poison.decode(e)
    end
  end

  defp create_response({:ok, body}, resp_map) do
    case resp_map.status_code do
      x when x in [200, 201, 204] ->
        {:ok, body}

      _ ->
        {:error, body}
    end
  end

  defp create_response({:error, error}, resp_body) do
    Logger.info("create_response: #{inspect(error)}, response body: #{inspect(resp_body)}")
    {:error, "There was an issue decoding the body"}
  end

  defp auth_header(sig) do
    "Signature keyId=\"#{api_key()}\",algorithm=\"hmac-sha1\",headers=\"date x-mod-nonce\",signature=\"#{
      sig
    }\""
  end

  defp create_signature(date, nonce) do
    :crypto.hmac(:sha, api_hmac(), "date: #{date}\nx-mod-nonce: #{nonce}")
    |> Base.encode64()
    |> URI.encode(&URI.char_unreserved?/1)
  end

  defp create_nonce_header do
    UUID.uuid1()
  end

  def rfc_7231_date do
    Timex.now()
    |> Timex.Timezone.convert("GMT")
    |> Timex.format!("%a, %d %b %Y %H:%M:%S %Z", :strftime)
  end

  defp api_base, do: Application.fetch_env!(:modulr, :api_base)
  defp api_version, do: Application.fetch_env!(:modulr, :api_version)
  defp api_key, do: Application.fetch_env!(:modulr, :api_key)
  defp api_hmac, do: Application.fetch_env!(:modulr, :api_hmac)
end
