# Modulr

Elixir wrapper for the Modulr API.

## Installation

1. Add `modulr` to your list of dependencies in mix.exs:

```elixir
def deps do
  [{:modulr, "~> 0.1.0"}]
end
```

then...

```elixir
mix deps.get
```

2. Add configuration to your app:

```elixir
config :modulr,
  api_base: "https://api-sandbox.modulrfinance.com/api-sandbox/ ",
  api_version: "1",
  api_key: "<your-api-key>",
  api_hmac: "<your-hmac>"
```

## For more information, see the Hex docs

You can read the docs [here](https://hexdocs.pm/modulr)

## Development Setup

If you are making changes to this codebase and want to test your code, you will need to copy the sample secret file.

```elixir
cp config/secret.sample.exs config/secret.exs
```

Then add your relevant Modulr access details here.
