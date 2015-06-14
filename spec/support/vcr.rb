require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.default_cassette_options = { serialize_with: :json }
  c.filter_sensitive_data('<API_KEY>') { ENV["OPEN_EXCHANGE_RATES_API_KEY"] }
end
