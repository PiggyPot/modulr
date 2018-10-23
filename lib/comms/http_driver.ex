defmodule Modulr.Comms.HttpDriver do
  def request(:get, path, params) do
    url_params = params |> URI.encode_query()

    "#{path}?#{url_params}"
    |> api_url()
    |> HTTPoison.get(headers(), options())
  end

  def request(:post, path, body) do
    path
    |> api_url()
    |> HTTPoison.post(body, headers(), options())
  end

  def request(:put, path, body) do
    path
    |> api_url()
    |> HTTPoison.put(body, headers(), options())
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
      "x-mod-nonce": nonce_header,
      "x-mod-version": api_version(),
      Authorization: auth_header
    ]
  end

  defp options do
    [ssl: [{:versions, [:"tlsv1.2"]}]]
  end

  defp auth_header(sig) do
    "Signature keyId=\"#{api_key()}\",algorithm=\"hmac-sha1\",headers=\"date x-mod-nonce\",signature=\"#{
      sig
    }\""
  end

  defp create_signature(date, nonce) do
    :crypto.hmac(:sha, api_hmac(), "date: #{date}\nx-mod-nonce: #{nonce}")
    |> Base.url_encode64()
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
